Player player = new Player(300,300);
char[][] map = new char[20][10];
int[] map_info;

void setup() {
  // each tile is 60x60 pixel
  // 20 by 10 board
  //50 pixels top and bottom for HUD
  size(1200, 700);
  getLevel(1);
}

void draw() {
  background(228, 225, 169);
  rect(500,500,60,60);  
  player.display();
  player.move();
}  

void getLevel(int level){
    String[] lines = loadStrings("map" + str(level) + ".txt");
    for (int i=0; i<10; i++){
       for (int j=0; j<20; j++){
           map[j][i] = lines[i].charAt(j);
       }
    }
    int time_interval = (int)lines[20];
    int change = (int)lines[21]
    //println(print2DArr(map));
}

String print2DArr (char[][] arr){
   String output = "";
   for (int i=0; i<arr[0].length; i++){
     output += "[";
      for (int j=0; j<arr.length; j++){
         output += arr[j][i];
         if (j != arr.length-1){
            output += ","; 
         }
      }
      if (i != arr[0].length-1){
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
