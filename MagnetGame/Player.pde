public class Player extends Entity {

  public Player(float x, float y) {
    super(x, y, 2.5, -1, color(255, 4, 4), 5, 200);
  }

  public void shoot(float x, float y) {
    PVector bulletDirection = new PVector(x - this.x, y - this.y);
    allProjectiles.add(new Proton(this.x,this.y, bulletDirection.normalize().mult(3)));
  }
}
