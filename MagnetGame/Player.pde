public class Player extends Entity {
  int mode=1;
  public Player(float x, float y) {
    super(x, y, 2.5, -1, color(255, 4, 4), 5, 200);
  }
  public void shoot(float x, float y) {
    PVector bulletDirection = new PVector(x - this.x, y - this.y);
    if (mode>0){
      if(ammoP>0){
        ammoP--;
        allProjectiles.add(new Proton(this.x,this.y, bulletDirection.normalize().mult(3)));
      }
    }
    else{
      if(ammoE>0){
        ammoE--;
        allProjectiles.add(new Electron(this.x,this.y, bulletDirection.normalize().mult(3.2)));
      }
    }
  }
  public void change() {
    mode=-mode;
  }
}
