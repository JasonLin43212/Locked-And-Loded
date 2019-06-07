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
  public void move() {
    PVector B=new PVector(0,0,Bfield()*0.009);
    if(Bfield()!=0){
      PVector a=v.cross(B)
        .mult(charge)
        .div(mass);
      v.add(a);
    }
    //println(v.mag());
    if ((x+v.x)/40<map.length){
      x+=v.x;
      if(map[(int)((x-10)/40)][(int)((y-75)/40)]=='X'||map[(int)((x+10)/40)][(int)((y-75)/40)]=='X'){
        v.x= -v.x;
        v.mult(0.79);
      }
    }
    if((y+v.y-70)/40<map[0].length){
      y+=v.y;
      if(map[(int)(x/40)][(int)((y-65)/40)]=='X'||map[(int)(x/40)][(int)((y-85)/40)]=='X'){
        v.y= -v.y;
        v.mult(0.79);
      }
    }
  }
}
