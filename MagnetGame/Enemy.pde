public abstract class Enemy extends Entity{
  
   public String projectiles;
  
   public Enemy(float x, float y, String projectiles){
      super(x,y,2.5,-1,color(4,50,4),5,200);
      this.projectiles = projectiles;
   }
}
