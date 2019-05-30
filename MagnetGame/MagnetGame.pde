Player player = new Player(300,300);

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
    String[] map = loadStrings("map" + str(level) + ".txt");
    for (int i=0; i<map.length; i++){
     print(map[i]); 
    }
}

void keyPressed() {
  player.controlMovement(keyCode, 1);
}

void keyReleased() {
  player.controlMovement(keyCode, 0);
}
