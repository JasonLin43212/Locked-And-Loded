public abstract class Entity {

  float x, y, direction, speed;
  int id, up, right, down, left, maxProjectiles, currentProjectiles, cooldown, maxCooldown;
  color entityColor;

  public Entity(float x, float y, float speed, int id, 
    color entityColor, int maxProjectiles, int maxCooldown) {
    this.x = x;
    this.y = y;
    this.direction = 0;
    this.id = id;
    this.entityColor = entityColor;
    this.maxProjectiles = maxProjectiles;
    this.currentProjectiles = 0;
    this.cooldown = maxCooldown;
    this.maxCooldown = maxCooldown;
    this.speed = speed;
    this.right = 0;
    this.left = 0;
    this.up = 0;
    this.down = 0;
  }

  public void move() {
    //if (movementCounter > 0) {
    //  movementCounter--;
    //}
    //float[] newLocation = collide(currentMap);
    //x = newLocation[0];
    //y = newLocation[1];
    x += speed*(right-left);
    y += speed*(down-up);
    //}
  }

  public void controlMovement(int num, int mode) {
    if (num == 87) {
      up=mode;
    }
    if (num == 65) {
      left=mode;
    }
    if (num == 83) {
      down=mode;
    }
    if (num == 68) {
      right=mode;
    }
  }
  
  public void display() {
    fill(entityColor);
    stroke(1);
    ellipse(x, y, 20, 20);
    //pushMatrix();
    //translate(x+15, y+15);
    //rotate(direction);
    //rect(2, -3, 24, 6);
    //popMatrix();
    //if (shootCoolDown > 0 && canFight) {
    //  shootCoolDown--;
    //}
  }
}
