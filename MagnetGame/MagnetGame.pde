import java.util.*;
import java.io.*;
Player player;
Proton hudp= new Proton(710, 720, new PVector(0, 0));
Electron hude=new Electron(785, 720, new PVector(0, 0));
ArrayList<Projectile> allProjectiles = new ArrayList<Projectile>();
ArrayList<Entity> allEntities = new ArrayList<Entity>();
char[][] map = new char[30][15];
int timeInterval = 0;
String[] change;
int changeIndex = -1;
int level=1;
int intervalCountdown = 0;
int ammoE=100, ammoP=100;

void setup() {
  // each tile is 40x40 pixel
  // 30 by 15 board
  //75 pixels top and bottom for HUD
  size(1200, 750);
  getLevel(level);
  allEntities.add(player);
}

void draw() {
  background(60, 90, 120);
  drawMap();
  for (int i=0; i<allProjectiles.size(); i++) {
    Projectile currentProjectile = allProjectiles.get(i);
    currentProjectile.display();
    currentProjectile.move();
    if (currentProjectile.v.mag() < 0.5) {
      allProjectiles.remove(currentProjectile);
      i -= 1;
    }
  }
  for (int i=0; i<allEntities.size(); i++) {
    Entity currentEntity = allEntities.get(i);
    currentEntity.display();
    currentEntity.move();
  }
  hudp.display();
  hude.display();
  fill(255, 255, 255);
  textSize(18);
  text(": "+ammoP, 730, 727);
  text(": "+ammoE, 795, 727);
  textSize(22);

  text("Ammo", 700, 700);
  text("Health", 50, 700);
  textSize(32);
  text("Magnetic Field Changes In: "+intervalCountdown, 700, 60); 
  text("Level "+level, 50, 60);

  intervalCountdown--; 
  if (intervalCountdown == 0) {
    intervalCountdown = timeInterval;
    changeIndex++;
    if (changeIndex == change.length) {
      changeIndex = 0;
    }
    changeFields();
  }
}

void changeFields() {
  for (int i=0; i<15; i++) {
    for (int j=0; j<30; j++) {
      int field_val = (int)map[j][i];
      int current_change = parseInt(change[changeIndex]);
      // Out of screen (Negative)
      if (field_val > 96 && field_val < 106) {
        field_val -= 96;
        field_val = -field_val;
      }
      // Into the screen (positive)
      else if (field_val > 48 && field_val < 58) {
        field_val -= 48;
      } 
      // Zero
      else if (field_val == 48 || field_val == 96) {
        field_val = 0;
      } else {
        continue;
      }
      int new_field = field_val + current_change;
      if (new_field > 9) {
        new_field = 9;
      }
      if (new_field < -9) {
        new_field = -9;
      }
      if (current_change == 0) {
        new_field = -new_field;
      }
      if (new_field >= 0) {
        new_field += 48;
      } else {
        new_field = -new_field;
        new_field += 96;
      }
      map[j][i] = (char)new_field;
    }
  }
}


void drawMag(int tile_x, int tile_y, int magnitude, boolean is_X) {
  int[][] spacings = {{20, 20}, {11, 11, 29, 29}, {9, 9, 20, 20, 31, 31}, {11, 11, 11, 29, 29, 11, 29, 29}, 
    {9, 9, 20, 20, 31, 31, 9, 31, 31, 9}, {11, 9, 11, 20, 11, 31, 29, 9, 29, 20, 29, 31}, 
    {9, 9, 9, 20, 9, 31, 20, 20, 31, 9, 31, 20, 31, 31}, 
    {9, 9, 9, 20, 9, 31, 31, 9, 31, 20, 31, 31, 20, 9, 20, 31}, 
    {9, 9, 9, 20, 9, 31, 31, 9, 31, 20, 31, 31, 20, 9, 20, 31, 20, 20}};
  fill(228, 225, 169);
  stroke(228, 225, 169);
  rect(tile_x*40, tile_y*40+75, 40, 40); 
  if (magnitude > 9) {
    magnitude = 9;
  }
  for (int k=0; k<magnitude; k++) {
    int x_center = tile_x*40 + spacings[magnitude-1][k*2];
    int y_center = (tile_y*40+75)+ spacings[magnitude-1][k*2+1];
    strokeWeight(2);
    //Into the Screen (Positive)
    if (is_X) {
      stroke(255, 0, 0);
      line(x_center-3, y_center-3, x_center+3, y_center+3);
      line(x_center-3, y_center+3, x_center+3, y_center-3);
    }
    //Out of the screen (Negative)
    else {
      stroke(34, 139, 34);
      strokeWeight(1);
      circle(x_center, y_center, 8);
      strokeWeight(3);
      line(x_center, y_center, x_center, y_center);
    }
  }
}

void drawMap() {
  for (int i=0; i<15; i++) {
    for (int j=0; j<30; j++) {
      strokeWeight(1);
      //Draw floor
      if (map[j][i] == ' ') {
        stroke(228, 225, 169);
        fill(228, 225, 169);
        rect(j*40, i*40+75, 40, 40);
      }
      //Draw Walls
      else if (map[j][i] == 'X') {
        stroke(128, 128, 128);
        fill(128, 128, 128);
        rect(j*40, i*40+75, 40, 40);
      }
      //Draw pits
      else if (map[j][i] == 'O') {
        stroke(0, 0, 0);
        fill(0, 0, 0);
        rect(j*40, i*40+75, 40, 40);
      }
      //Draw magnetic fields
      else {
        int field_val = (int)map[j][i];
        //Out of screen (Negative)
        if (field_val > 96 && field_val < 106) {
          field_val -= 96;
          drawMag(j, i, field_val, false);
        }
        // Point into the screen (Positive)
        else if (field_val > 48 && field_val < 58) {
          field_val -= 48;
          drawMag(j, i, field_val, true);
        } else {
          stroke(228, 225, 169);
          fill(228, 225, 169);
          rect(j*40, i*40+75, 40, 40);
        }
      }
    }
  }
}

void getLevel(int level) {
  //Lines 0-14 are map, each 40 characters long
  //Line 15 is time interval, one number
  //Line 16 is change, an array of numbers to add or multiply
  String[] lines = loadStrings("map" + str(level) + ".txt");
  for (int i=0; i<15; i++) {
    for (int j=0; j<30; j++) {
      char cur_char = lines[i].charAt(j);
      if (cur_char == 'P') {
        player = new Player(j*40, i*40+75);
        map[j][i] = ' ';
      } else if (cur_char == 'z') {
        allEntities.add(new Enemy(j*40, i*40+75,"p",color(50,40,30)));
        map[j][i] = ' ';
      }
      else {
        map[j][i] = cur_char;
      }
    }
  }
  timeInterval = Integer.parseInt(lines[15].split("\n", 0)[0]);
  intervalCountdown = timeInterval;
  // 1-9 (-9) - (-1)  0 for negate
  change = lines[16].split("\n", 0)[0].split(",");

  //println(time_interval);
  //println(change);
  //println(print2DArr(map));
}

String print2DArr (char[][] arr) {
  String output = "";
  for (int i=0; i<arr[0].length; i++) {
    output += "[";
    for (int j=0; j<arr.length; j++) {
      output += arr[j][i];
      if (j != arr.length-1) {
        output += ",";
      }
    }
    if (i != arr[0].length-1) {
      output += "]\n";
    }
  }
  return output + "]";
}

void keyPressed() {
  player.controlMovement(keyCode, 1);
}

void keyReleased() {
  if (keyCode == 32) {
    player.shoot(mouseX, mouseY);
  } else if (keyCode==17) {
    player.change();
  } else {
    player.controlMovement(keyCode, 0);
  }
}

void mouseClicked() {
  player.shoot(mouseX, mouseY);
}
