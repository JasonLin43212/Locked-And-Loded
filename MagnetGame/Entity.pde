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
    int hor = right-left;
    int ver = down-up;
    float newX = x+speed*hor;
    float newY = y+speed*ver;
    float oldX = x;
    float oldY = y;  
    //left
    if (hor == 1 && ver == 0) {
      if (!(map[(int)((x+11)/40)][(int)((y-75)/40)] == 'X' || map[(int)((x+11)/40)][(int)((y-75)/40)] == 'O' ||
        map[(int)((x+9)/40)][(int)((y-75+9)/40)] == 'X' || map[(int)((x+9)/40)][(int)((y-75+9)/40)] == 'O' ||
        map[(int)((x+9)/40)][(int)((y-75-9)/40)] == 'X' || map[(int)((x+9)/40)][(int)((y-75-9)/40)] == 'O')) {
        x = newX;
      }
    }
    //right
    else if (hor == -1 && ver == 0) {
      if (!(map[(int)((x-11)/40)][(int)((y-75)/40)] == 'X' || map[(int)((x-11)/40)][(int)((y-75)/40)] == 'O' ||
        map[(int)((x-9)/40)][(int)((y-75+9)/40)] == 'X' || map[(int)((x-9)/40)][(int)((y-75+9)/40)] == 'O' ||
        map[(int)((x-9)/40)][(int)((y-75-9)/40)] == 'X' || map[(int)((x-9)/40)][(int)((y-75-9)/40)] == 'O')) {
        x = newX;
      }
    }
    //down
    else if (hor == 0 && ver == 1) {
      if (!(map[(int)(x/40)][(int)((y-75+11)/40)] == 'X' || map[(int)(x/40)][(int)((y-75+11)/40)] == 'O' ||
        map[(int)((x-9)/40)][(int)((y-75+9)/40)] == 'X' || map[(int)((x-9)/40)][(int)((y-75+9)/40)] == 'O' ||
        map[(int)((x+9)/40)][(int)((y-75+9)/40)] == 'X' || map[(int)((x+9)/40)][(int)((y-75+9)/40)] == 'O')) {
        y = newY;
      }
    }
    //up
    else if (hor == 0 && ver == -1) {
      if (!(map[(int)(x/40)][(int)((y-75-11)/40)] == 'X' || map[(int)(x/40)][(int)((y-75-11)/40)] == 'O' ||
        map[(int)((x-9)/40)][(int)((y-75-9)/40)] == 'X' || map[(int)((x-9)/40)][(int)((y-75-9)/40)] == 'O' ||
        map[(int)((x+9)/40)][(int)((y-75-9)/40)] == 'X' || map[(int)((x+9)/40)][(int)((y-75-9)/40)] == 'O')) {
        y = newY;
      }
    }
    //bottom-right
    else if (hor == 1 && ver == 1) {
      //right wall
      y = newY;
      x = newX;
      if (map[(int)((x+11)/40)][(int)((y-75)/40)] == 'X' || map[(int)((x+11)/40)][(int)((y-75)/40)] == 'O' ||
        map[(int)((x+11)/40)][(int)((y-75-11)/40)] == 'X' || map[(int)((x+11)/40)][(int)((y-75-11)/40)] == 'O') {
        x = oldX;
      }
      //bottom wall
      if (map[(int)(x/40)][(int)((y-75+11)/40)] == 'X' || map[(int)(x/40)][(int)((y-75+11)/40)] == 'O' ||
        map[(int)((x-11)/40)][(int)((y-75+11)/40)] == 'X' || map[(int)((x-11)/40)][(int)((y-75+11)/40)] == 'O') {
        y = oldY;
      }
      //corner wall (right)
      if (!(map[(int)(x/40)][(int)((y-75+11)/40)] == 'X' || map[(int)(x/40)][(int)((y-75+11)/40)] == 'O') &&
        !(map[(int)((x+11)/40)][(int)((y-75)/40)] == 'X' || map[(int)((x+11)/40)][(int)((y-75)/40)] == 'O') &&
        (map[(int)((x+11)/40)][(int)((y-75+11)/40)] == 'X' || map[(int)((x+11)/40)][(int)((y-75+11)/40)] == 'O')) {
          if (oldX - ((int)(oldX/40)*40) >= oldY - ((int)((oldY-75)/40)*40)){
            y = oldY;
          }
          else {
            x = oldX; 
          }
      }
    }
    //bottom-left
    else if (hor == -1 && ver == 1) {
      y = newY;
      x = newX;
      //left wall
      if (map[(int)((x-11)/40)][(int)((y-75)/40)] == 'X' || map[(int)((x-11)/40)][(int)((y-75)/40)] == 'O' ||
        map[(int)((x-9)/40)][(int)((y-75-9)/40)] == 'X' || map[(int)((x-9)/40)][(int)((y-75-9)/40)] == 'O') {
        x = oldX;
      }
      //bottom wall
      if (map[(int)(x/40)][(int)((y-75+11)/40)] == 'X' || map[(int)(x/40)][(int)((y-75+11)/40)] == 'O' ||
        map[(int)((x+9)/40)][(int)((y-75+9)/40)] == 'X' || map[(int)((x+9)/40)][(int)((y-75+9)/40)] == 'O') {
        y = oldY;
      }
      //corner wall (down)
      if (!(map[(int)(x/40)][(int)((y-75+11)/40)] == 'X' || map[(int)(x/40)][(int)((y-75+11)/40)] == 'O') &&
        !(map[(int)((x-11)/40)][(int)((y-75)/40)] == 'X' || map[(int)((x-11)/40)][(int)((y-75)/40)] == 'O') &&
        (map[(int)((x-11)/40)][(int)((y-75+11)/40)] == 'X' || map[(int)((x-11)/40)][(int)((y-75+11)/40)] == 'O')) {
          if (oldX - ((int)(oldX/40)*40) >= 40 - (oldY - ((int)((oldY-75)/40)*40))){
            x = oldX;
          }
          else {
            y = oldY; 
          }
      }
    }
    //top-right
    else if (hor == 1 && ver == -1) {
      y = newY;
      x = newX;
      //right wall
      if (map[(int)((x+11)/40)][(int)((y-75)/40)] == 'X' || map[(int)((x+11)/40)][(int)((y-75)/40)] == 'O' ||
        map[(int)((x+9)/40)][(int)((y-75+9)/40)] == 'X' || map[(int)((x+9)/40)][(int)((y-75+9)/40)] == 'O') {
        x = oldX;
      }
      //top wall
      if (map[(int)(x/40)][(int)((y-75-11)/40)] == 'X' || map[(int)(x/40)][(int)((y-75-11)/40)] == 'O' ||
        map[(int)((x-9)/40)][(int)((y-75-9)/40)] == 'X' || map[(int)((x-9)/40)][(int)((y-75-9)/40)] == 'O') {
        y = oldY;
      }
      //corner (top)
      if (!(map[(int)(x/40)][(int)((y-75-11)/40)] == 'X' || map[(int)(x/40)][(int)((y-75-11)/40)] == 'O') &&
        !(map[(int)((x+11)/40)][(int)((y-75)/40)] == 'X' || map[(int)((x+11)/40)][(int)((y-75)/40)] == 'O') &&
        (map[(int)((x+11)/40)][(int)((y-75-11)/40)] == 'X' || map[(int)((x+11)/40)][(int)((y-75-11)/40)] == 'O')) {
          if (oldX - ((int)(oldX/40)*40) >= 40 - (oldY - ((int)((oldY-75)/40)*40))){
            y = oldY;
          }
          else {
            x = oldX; 
          }
      }
    }
    //top-left
    else if (hor == -1 && ver == -1) {
      y = newY;
      x = newX;
      //left wall
      if (map[(int)((x-11)/40)][(int)((y-75)/40)] == 'X' || map[(int)((x-11)/40)][(int)((y-75)/40)] == 'O' ||
        map[(int)((x-9)/40)][(int)((y-75+9)/40)] == 'X' || map[(int)((x-9)/40)][(int)((y-75+9)/40)] == 'O') {
        x = oldX;
      }
      //top wall
      if (map[(int)(x/40)][(int)((y-75-11)/40)] == 'X' || map[(int)(x/40)][(int)((y-75-11)/40)] == 'O' ||
        map[(int)((x+9)/40)][(int)((y-75-9)/40)] == 'X' || map[(int)((x+9)/40)][(int)((y-75-9)/40)] == 'O') {
        y = oldY;
      }
      //corner wall (left)
      if (!(map[(int)(x/40)][(int)((y-75-11)/40)] == 'X' || map[(int)(x/40)][(int)((y-75-11)/40)] == 'O') &&
        !(map[(int)((x-11)/40)][(int)((y-75)/40)] == 'X' || map[(int)((x-11)/40)][(int)((y-75)/40)] == 'O') &&
        (map[(int)((x-11)/40)][(int)((y-75-11)/40)] == 'X' || map[(int)((x-11)/40)][(int)((y-75-11)/40)] == 'O')) {
          if (oldX - ((int)(oldX/40)*40) >= oldY - ((int)((oldY-75)/40)*40)){
            x = oldX;
          }
          else {
            y = oldY; 
          }
      }
    }
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
    circle(x, y, 20);
  }
  
  public abstract void shoot(float x, float y);
}
