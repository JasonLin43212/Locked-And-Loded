public class Electron extends Projectile {

  public Electron(float xcor, float ycor,  PVector v) {
    super(xcor, ycor, v, true, -1, 0);
  }
  public void display() {
    fill(155, 255, 0);
    stroke(1);
    ellipse(super.x, super.y, 10, 10);
    strokeWeight(3);
    line(super.x-4, super.y, super.x+4, super.y);
    strokeWeight(1);
  }
}
