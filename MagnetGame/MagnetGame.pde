Player player = new Player(300, 300);
char[][] map = new char[30][15];
int[] map_info;

void setup() {
  // each tile is 40x40 pixel
  // 30 by 15 board
  //75 pixels top and bottom for HUD
  size(1200, 750);
  getLevel(1);
}

void draw() {
  background(60, 90, 120);
  drawMap();
  player.display();
  player.move();
}  

void drawMag(int tile_x, int tile_y, int magnitude, boolean is_X) {
  float[][] spacings = {{20,20},{13,13,26,26},{10,10,20,20,30,30},{13,13,13,26,26,13,26,26},
                        {10,10,20,20,30,30,10,30,30,10},{13,10,13,20,13,30,26,10,26,20,26,30},
                        {10,10,10,20,10,30,20,20,30,10,30,20,30,30},
                        {10,10,10,20,10,30,30,10,30,20,30,30,20,10,20,30},
                        {10,10,10,20,10,30,30,10,30,20,30,30,20,10,20,30,20,20}};
  for (int k=0; k<magnitude; k++) {
    //stroke(255,0,0);
    int x_center = tile_x*40 + 1;
    //int y_center = (tile_y*30+75)+(mag_interval*(int)((k+1)/field_val));
    //line(x_center-1, y_center-1, x_center+1, y_center+1);
    //line(x_center-1, y_center+1, x_center+1, y_center-1);
  }
}

void drawMap() {
  for (int i=0; i<15; i++) {
    for (int j=0; j<30; j++) {
      //Draw floor
      if (map[j][i] == ' ') {
        //stroke(228, 225, 169);
        fill(228, 225, 169);
        rect(j*40, i*40+75, 40, 40);
      }
      //Draw Walls
      else if (map[j][i] == 'X') {
        //stroke(128,128,128);
        fill(128, 128, 128);
        rect(j*40, i*40+75, 40, 40);
      }
      //Draw pits
      else if (map[j][i] == 'O') {
        //stroke(0,0,0);
        fill(0, 0, 0);
        rect(j*40, i*40+75, 40, 40);
      }
      //Draw magnetic fields
      else {
        int field_val = (int)map[j][i];
        // Point into the screen
        if (field_val > 96 && field_val < 106) {
          field_val -= 96;
          //drawMag(j, i, field_val, true);
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
      map[j][i] = lines[i].charAt(j);
    }
  }
  int time_interval = Integer.parseInt(lines[15].split("\n", 0)[0]);
  int change = Integer.parseInt(lines[16].split("\n", 0)[0]);
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
  player.controlMovement(keyCode, 0);
}
