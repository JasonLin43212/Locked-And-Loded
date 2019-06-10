public class Player extends Entity {

  public Player(float x, float y) {
    super(x, y, 2.5, -1, color(255, 4, 4), 5, 200);
  }

  public void shoot(float x, float y) {
    PVector bulletDirection = new PVector(this.x - x, this.y - y);
    allProjectiles.add(new Proton(this.x,this.y));
  }
}
