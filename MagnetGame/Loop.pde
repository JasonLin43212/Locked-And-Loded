public class Loop extends Projectile {
  public Loop(float xcor, float ycor) {
    super(xcor, ycor, new PVector(2.0, 2.0), false, 1, 0);
  }
  public void display() {
    stroke(1);
    rectMode(CENTER);
    fill(200, 200, 200);
    rect(super.x, super.y, 20, 20);
    fill(228, 225, 169);
    rect(super.x, super.y, 16, 16);
    rectMode(CORNER);
    strokeWeight(1);
  }
}
