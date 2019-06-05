public abstract class Projectile {
    float x,y,mass;
    PVector v;
    boolean isParticle;
    int charge,numBounces;

    public Projectile (float xcor,float ycor,PVector vel,
                        boolean isP, int c,int nb ) {
        x=xcor;
        y=ycor;
        v=vel;
        isParticle=isP
        charge=c
        numBounces=nb
    }
    public int Bfield(){
        int bf=0;
        if isParticle:
            bf=(int) map[(int)x/60][(int)((y-50)/60)];
            if bf>10:
                bf-=96;
                bf=-bf;
        else:
            println("Conducting Loop");
        return bf;
    }
    public void move(){
        PVector a=v.mult(Bfield())
                    .mult(charge)
                    .div(mass);
        v.add(a)
    }


}
