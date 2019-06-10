public class Electron extends Projectile{
   
    public Electron(float xcor, float ycor){
        super(xcor,ycor,new PVector(2.5,2.5),true,-1,0);
    }
    public void display(){
        if (super.v.mag()>0.01){
            fill(155,255,0);
            stroke(1);
            ellipse(super.x, super.y, 10, 10);
            strokeWeight(3);
            line(super.x-4,super.y,super.x+4,super.y);
            strokeWeight(1);
        }
    }

}