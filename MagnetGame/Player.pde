public class Player extends Entity {

  int mode=1;

  public Player(float x, float y) {
    super(x, y, 2.5, -1, color(255, 4, 4), 5, 200);
  }

  public void shoot(float x, float y) {
    PVector bulletDirection;
    if (wmouse){
      bulletDirection = new PVector(x-this.x,y-this.y);
    }
    else {
      bulletDirection = PVector.fromAngle(direction);
    }
    if (mode>0) {
      if (ammoP>0) {  
        ammoP--;
        allProjectiles.add(new Proton(this.x+bulletDirection.normalize().x*16, this.y+bulletDirection.normalize().y*16, 
          bulletDirection.normalize().mult(2.5), id));
          
      }
    } else {
      if (ammoE>0) {
        ammoE--;
        allProjectiles.add(new Electron(this.x+bulletDirection.normalize().x*11, this.y+bulletDirection.normalize().y*11, 
          bulletDirection.normalize().mult(3), id));
      }
    }
  }
  public void change() {
    mode=-mode;
    bullet=-bullet;
  }

  public void display() {
    super.display();                  
    if (wmouse){
       direction = atan2(mouseY-y,mouseX-x); 
    }
    pushMatrix();
    translate(x, y);
    rotate(direction);
    triangle(18, 0, 13,4,13,-4);
    popMatrix();
  }
}
