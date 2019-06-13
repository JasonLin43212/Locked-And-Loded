public class Enemy extends Entity {

  String projectiles;
  int movementCounter, shootingCounter;
  float nextX, nextY;

  public Enemy(float x, float y, String projectiles, color enemyColor) {
    super(x, y, 2.5, -1, enemyColor, 5, 200);
    this.projectiles = projectiles;
    this.movementCounter = 1;
    this.shootingCounter = 300;
  }

  public void shoot(float x, float y) {
    //use global difficuty to determine accuracy
    print("emeny shoot");
  }

  public void move() {
    super.move();
    movementCounter--;

    if (movementCounter == 0) {
      //println(nextX+","+nextY);
      boolean hasChosen = false;
      while (hasChosen == false) {
        nextX = x + random(300) - 150;
        nextY = y + random(300) - 150;
        if (nextX < 20 || nextX > 1150 || nextY < 95 || nextY > 655) {
          continue;
        }
        if (map[(int)(nextX/40)][(int)((nextY-75)/40)] != 'X' && map[(int)(nextX/40)][(int)((nextY-75)/40)] != 'O') {
          hasChosen = true; 
          movementCounter = 50;
        }
      }
    }
    if (abs(x-nextX) > 10){
      if (x < nextX) {
        right = 1;
        left = 0;
      }
      if (x > nextX) {
        right = 0;
        left = 1;
      }
    }
    if (abs(y-nextY) > 10){
      if (y < nextY) {
        up = 0;
        down = 1;
      }
      if (y > nextY) {
        up = 1;
        down = 0;
      }
    }
    else {
      up = 0;
      down = 0;
      left = 0;
      right = 0;
    }
  }
}
