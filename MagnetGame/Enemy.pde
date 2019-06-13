public class Enemy extends Entity {

  String projectiles;
  int movementCounter, shootingCounter;
  float nextX, nextY;

  public Enemy(float x, float y, String projectiles, color enemyColor, int id) {
    super(x, y, 1.5, id, enemyColor, 5, 200);
    this.projectiles = projectiles;
    this.movementCounter = 1;
    this.shootingCounter = 30;
  }

  public void shoot(float x, float y) {
    shootingCounter--;
    if (shootingCounter == 0) {
      PVector bulletDirection = new PVector(x - this.x, y - this.y);
      allProjectiles.add(new Proton(this.x, this.y, bulletDirection.normalize().mult(3),id));
      shootingCounter = 100;
    }
  }

  public void move() {
    super.move();
    shoot(x+random(10)-5, y+random(10)-5);
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
          movementCounter = (int) (random(40) + 30);
        }
      }
    }
    if (abs(x-nextX) > 10) {
      if (x < nextX) {
        right = 1;
        left = 0;
      }
      if (x > nextX) {
        right = 0;
        left = 1;
      }
    }
    if (abs(y-nextY) > 10) {
      if (y < nextY) {
        up = 0;
        down = 1;
      }
      if (y > nextY) {
        up = 1;
        down = 0;
      }
    } else {
      up = 0;
      down = 0;
      left = 0;
      right = 0;
    }
  }
}
