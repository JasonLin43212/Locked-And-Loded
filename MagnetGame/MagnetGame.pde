import java.util.*;
import java.io.*;
Player player;
Proton hudp= new Proton(710, 720, new PVector(0, 0), -1);
Electron hude=new Electron(785, 720, new PVector(0, 0), -1);
int nextEntityId = 0;
ArrayList<Projectile> allProjectiles = new ArrayList<Projectile>();
ArrayList<Entity> allEntities = new ArrayList<Entity>();
PImage go;
char[][] map = new char[30][15];
int timeInterval = 0;
String[] change;
int changeIndex = -1;
int level=1;
int intervalCountdown = 0;
int ammoE = -1, ammoP = -1;
int mode=0;
int bullet=1;
float angle;
PFont arcade;
int difficulty = 0;
boolean wmouse = true;
boolean running=true;
boolean saveProgress = false;

void setup() {
  // each tile is 40x40 pixel
  // 30 by 15 board
  //75 pixels top and bottom for HUD
  arcade=createFont("ARCADE_N.TTF", 10);
  size(1200, 750);
  getLevel(level);
  allEntities.add(player);
  go=loadImage("GOver.png");
}
public void reset(int level) {
  this.level=level;
  allEntities = new ArrayList<Entity>();
  getLevel(level);
  allEntities.add(player);
  allProjectiles = new ArrayList<Projectile>();
  bullet=1;
}
void draw() {
  textFont(arcade);
  if (mode==0) {
    PImage logo=loadImage("logo.png");
    background(54, 151, 160);
    stroke(0, 0, 0);
    fill(255, 255, 255);
    rect(490, 360, 240, 80);
    textSize(22);
    fill(0, 0, 0);
    logo.resize(700, 60);
    image(logo, 250, 200);
    text("Start Game", 508, 412);
    stroke(0, 0, 0);
    fill(255, 255, 255);
    rect(490, 460, 240, 80);
    textSize(22);
    fill(0, 0, 0);

    text("Controls", 522, 512);
    stroke(0, 0, 0);
    if (!saveProgress) {
      fill(255, 255, 255);
    } else {
      fill(135, 206, 250);
    }
    rect(490, 560, 240, 80);
    textSize(16);
    fill(0, 0, 0);
    text("Save Progress?", 502, 612);
  }
  if (mode==3) {
    background(238, 238, 238);
    PImage arrows, space, shift, wasd, mouse, p;
    wasd=loadImage("wasd.png");
    shift=loadImage("shift.png");
    p=loadImage("P.png");
    textSize(11);
    fill(0, 0, 0);
    wasd.resize((int)(wasd.width*1.5), (int)(wasd.height*1.5));
    image(wasd, 100, 230);
    p.resize((int)(p.width*1.5), (int)(p.height*1.5));
    image(p, 530, 200);
    text("Press P to pause/unpause", 480, 310);
    text("Use the WASD keys to move the player", 120, 430);
    shift.resize((int)(shift.width*1.5), (int)(shift.height*1.5));
    image(shift, 120, 450);
    text("Use the Shift key to switch bullets", 120, 550);
    if (!wmouse) {
      fill(135, 206, 250);
      rect(100, 100, 180, 60);
      textSize(14);
      fill(0, 0, 0);
      text("Keyboard", 135, 140);
      fill(255, 255, 255);
      rect(300, 100, 210, 60);
      textSize(11);
      fill(0, 0, 0);
      text("Keyboard and Mouse", 308, 138);

      arrows=loadImage("arrows.png");
      arrows.resize(281, 209);
      image(arrows, 800, 200);
      text("Use the arrow keys to aim", 810, 450);
      space=loadImage("spacebar.png");
      space.resize((int)(space.width*1.5), (int)(space.height*1.5));
      image(space, 360, 570);
      text("Use the spacebar to shoot", 480, 680);
    } else {
      fill(255, 255, 255);
      rect(100, 100, 180, 60);
      textSize(14);
      fill(0, 0, 0);
      text("Keyboard", 135, 140);
      fill(135, 206, 250);
      rect(300, 100, 210, 60);
      textSize(11);
      fill(0, 0, 0);
      text("Keyboard and Mouse", 308, 138);

      mouse=loadImage("mouse.png");
      mouse.resize((int)(mouse.width*1.2), (int)(mouse.height*1.2));
      image(mouse, 800, 200);
      text("Move the mouse to aim", 760, 500);
      text("Click the left mouse button to shoot", 760, 522);
    }
    stroke(0, 0, 0);
    fill(255, 255, 255);
    rect(900, 100, 180, 60);
    textSize(14);
    fill(0, 0, 0);

    text("Start Game", 922, 140);
    stroke(0, 0, 0);
    fill(255, 255, 255);
    rect(700, 100, 180, 60);
    textSize(14);
    fill(0, 0, 0);

    text("Main Menu", 730, 140);
  }
  if (mode==1) {
    background(60, 90, 120);
    drawMap();

    for (int i=0; i<allProjectiles.size(); i++) {
      Projectile currentProjectile = allProjectiles.get(i);
      currentProjectile.display();
      if (running) {
        currentProjectile.move();
      }
      if (currentProjectile.numBounces >= 2) {
        allProjectiles.remove(currentProjectile);
        i -= 1;
      }
    }
    if (allEntities.size()==1&&allEntities.contains(player)) {
      mode=4;
    }
    if (!allEntities.contains(player)) {
      mode=2;
    }
    if (ammoP == 0 && ammoE == 0) {
      int playerProj = 0;
      for (int i=0; i<allProjectiles.size(); i++) {
        if (allProjectiles.get(i).parentId == -1) {
          playerProj++;
        }
      }
      if (playerProj == 0) {
        mode = 2;
      }
    }
    for (int i=0; i<allEntities.size(); i++) {
      Entity currentEntity = allEntities.get(i);
      currentEntity.display();
      if (running) {
        currentEntity.move();
      }
      for (int j=0; j<allProjectiles.size(); j++) {
        Projectile curProj = allProjectiles.get(j);
        float killDist = 17.5;
        if (curProj.charge == -1) {
          killDist = 15;
        }
        if (dist(curProj.x, curProj.y, currentEntity.x, currentEntity.y) <= killDist &&
          ((curProj.parentId >= 0 && currentEntity.id == -1) || (curProj.parentId == -1 && currentEntity.id != -1))) {
          allEntities.remove(currentEntity);
          allProjectiles.remove(curProj);
          i--;
          break;
        }
      }
    }
    hudp.display();
    hude.display();
    fill(255, 255, 255);
    textSize(10);
    text(":"+ammoP, 730, 727);
    text(":"+ammoE, 795, 727);
    textSize(12);
    text("Ammo", 700, 700);
    text("In Use:", 1000, 725);
    if (bullet>0) {
      Proton upr=new Proton(1090, 718, new PVector(0, 0), -1);
      upr.display();
    } else {
      Electron uel=new Electron(1090, 718, new PVector(0, 0), -1);
      uel.display();
    }
    textSize(20);
    fill(255, 255, 255);
    text("Locked & Loded"+"\u2122", 50, 700);
    textSize(16);
    text("Magnetic Field Changes In: "+ ((intervalCountdown/60)+1) + " sec", 650, 60); 
    text("Level "+level, 50, 60);
    if (running) {
      intervalCountdown--; 
      if (intervalCountdown == 0) {
        intervalCountdown = timeInterval;
        changeIndex++;
        if (changeIndex >= change.length) {
          changeIndex = 0;
        }
        changeFields();
      }
    }
    if (!running) {
      fill(0, 0, 0, 200);
      rect(0, 0, 1200, 750);
      fill(255, 255, 255);
      textSize(50);
      text("Paused", 450, 340);
    }
    if (mode==2) {
      fill(0, 0, 0, 200);
      rect(0, 0, 1200, 750);
      stroke(0, 0, 0);
      fill(255, 255, 255);
      rect(490, 360, 240, 80);
      textSize(20);
      fill(0, 0, 0);
      go.resize(420, 70);
      image(go, 390, 200);
      text("Play Again", 510, 412);
    }
    if (mode==4) {
      fill(0, 100, 0, 50);
      rect(0, 0, 1200, 750);
      stroke(0, 0, 0);
      fill(255, 255, 255);
      textSize(50);
      text("Cleared Level "+level, 280, 240);
      if (level!=6) {
        fill(255, 255, 255);
        rect(490, 360, 240, 80);
        textSize(21);
        fill(0, 0, 0);

        text("Next Level", 510, 412);
      } else {
        text("You Win", 450, 380);
      }
      stroke(0, 0, 0);
      fill(255, 255, 255);
      rect(490, 460, 240, 80);
      textSize(21);
      fill(0, 0, 0);

      text("Main Menu", 520, 512);
    }
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
        player = new Player(j*40+20, i*40+95);
        map[j][i] = ' ';
      } else if (cur_char == 'z') {
        allEntities.add(new Enemy(j*40, i*40+75, "p", color(255, 127, 80), nextEntityId));
        nextEntityId++;
        map[j][i] = ' ';
      } else if (cur_char == 'y') {
        allEntities.add(new Enemy(j*40, i*40+75, "e", color(255, 0, 255), nextEntityId));
        nextEntityId++;
        map[j][i] = ' ';
      } else {
        map[j][i] = cur_char;
      }
    }
  }
  timeInterval = Integer.parseInt(lines[15].split("\n", 0)[0]);
  intervalCountdown = timeInterval;
  // 1-9 (-9) - (-1)  0 for negate
  change = lines[16].split("\n", 0)[0].split(",");
  ammoP = Integer.parseInt(lines[17].split("\n", 0)[0]);
  ammoE = Integer.parseInt(lines[18].split("\n", 0)[0]);
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
  if (keyCode == 37 && !wmouse) {
    player.direction -= PI/22.5;
  } else if (keyCode == 39 && !wmouse) {
    player.direction += PI/22.5;
  } else {
    player.controlMovement(keyCode, 1);
  }
}

void keyReleased() {
  if (keyCode == 32) {
    player.shoot(mouseX, mouseY);
  }
  if (keyCode==16) {
    player.change();
  }
  if (keyCode==80) {
    running=!running;
  }
  player.controlMovement(keyCode, 0);
}

void mouseClicked() {
  if (mode==0 || mode==2) {
    if (mode==0) {
      if (mouseX>=490 && mouseX<=730 && mouseY>=360 && mouseY<=440) {
        mode=1;
      } else if (mouseX>=490 && mouseX<=730 && mouseY>=460 && mouseY<=540) {
        mode=3;
      } else if (mouseX >= 490 && mouseX<730 && mouseY>560 && mouseY<640) {
        saveProgress = !saveProgress;
      }
    }
    if (mode==2) {
      if (mouseX>=490 && mouseX<=730 && mouseY>=360 && mouseY<=440) {
        if (saveProgress) {
          reset(level);
        } else {
          reset(1);
        }
        mode=1;
      }
    }
  } else if (mode==3) {
    if (mouseX>=100 && mouseX<=280 && mouseY>=100 && mouseY<=160) {
      wmouse=false;
    } else if (mouseX>=300 && mouseX<=510 && mouseY>=100 && mouseY<=160) {
      wmouse=true;
    } else if (mouseX>=900 && mouseX<=1080 && mouseY>=100 && mouseY<=160) {
      mode=1;
    } else if (mouseX>=700 && mouseX<=880 && mouseY>=100 && mouseY<=160) {
      mode = 0;
    }
  } else if (mode==1) {
    player.shoot(mouseX, mouseY);
  } else if (mode==4) {
    if (mouseX>=490 && mouseX<=730 && mouseY>=360 && mouseY<=440) {
      level+=1;
      reset(level);
      mode=1;
    } else if (mouseX>=490 && mouseX<=730 && mouseY>=460 && mouseY<=540) {
      reset(1);
      mode=0;
    }
  }
}
