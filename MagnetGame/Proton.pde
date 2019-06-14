public class Proton extends Projectile {
  public Proton(float xcor, float ycor, PVector v, int parentId) {
    super(xcor, ycor, v, true, 1, 0,parentId);
  }
  public void display() {
    fill(0, 255, 255);
    stroke(1);
    ellipse(super.x, super.y, 15, 15);
    strokeWeight(3);
    line(super.x, super.y-4, super.x, super.y+4);
    line(super.x-4, super.y, super.x+4, super.y);
    strokeWeight(1);
  }
}
