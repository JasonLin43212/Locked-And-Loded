public class Proton extends Projectile{
    public Proton(float xcor, float ycor){
        super(xcor,ycor,new PVector(2.0,2.0),true,1,0);
    }
    public void display(){
        if (super.v.mag()>0.01){
            fill(0,255,255);
            stroke(1);
            ellipse(super.x, super.y, 15, 15);
            strokeWeight(3);
            line(super.x,super.y-4,super.x,super.y+4);
            line(super.x-4,super.y,super.x+4,super.y);
            strokeWeight(1);
        }
    }

}