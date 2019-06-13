public abstract class Projectile {
  float x, y, mass;
  PVector v;
  boolean isParticle;
  int charge, numBounces;

  public Projectile (float xcor, float ycor, PVector vel, 
    boolean isP, int c, int nb ) {
    x=xcor;
    y=ycor;
    v=vel;
    isParticle=isP;
    charge=c;
    numBounces=nb;
    if (charge>0){
      mass=2;
    }
    else{
      mass=0.5;
    }

  }
  public int Bfield() {
    int bf=0;
    if (isParticle) { 
      int field=(int) map[(int)(x/40)][(int)((y-75)/40)];
      if(field>48 && field<58){
        bf=field-48;
      }
      if (field>96 && field<106) {
        bf=field-96;
        bf=-bf;
      }
    } else {
      println("Conducting Loop");
    }
    return bf;
  }
  public abstract void display();
  public void move() {
    PVector B=new PVector(0,0,Bfield()*0.005);
    if(Bfield()!=0){
      PVector a=v.cross(B)
        .mult(charge)
        .div(mass);
      v.add(a);
    }
    //println(v.mag());
    x+=v.x;
    if(map[(int)((x-5)/40)][(int)((y-75)/40)]=='X'||map[(int)((x+15)/40)][(int)((y-75)/40)]=='X'){
      x-=v.x;
      v.x= -v.x;
      v.mult(0.53);
    }
    y+=v.y;
    if(map[(int)(x/40)][(int)((y-70)/40)]=='X'||map[(int)(x/40)][(int)((y-80)/40)]=='X'){
      y-=v.y;
      v.y= -v.y;
      v.mult(0.53);
    }
  }
}
