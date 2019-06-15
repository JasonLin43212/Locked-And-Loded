public class Enemy extends Entity {

  String projectiles;
  int movementCounter, shootingCounter;
  float nextX, nextY;

  public Enemy(float x, float y, String projectiles, color enemyColor, int id) {
    super(x, y, 1.5, id, enemyColor, 5, 200);
    this.projectiles = projectiles;
    this.movementCounter = 1;
    this.shootingCounter = 30;
  }

  public void shoot(float x, float y) {
    shootingCounter--;
    if (shootingCounter == 0) {
      char curProj = projectiles.charAt((int)random(projectiles.length()));
      PVector bulletDirection = new PVector(0,0);
      boolean foundDirection = false;
      for (int i=0; i<40; i++) {
        if (foundDirection){
          //print("found direction");
           break; 
        }
        bulletDirection = PVector.fromAngle(i*2*PI/40);
        PVector testDirection = PVector.fromAngle(i*2*PI/40);
        float testX = this.x+testDirection.normalize().x*16;
        float testY = this.y+testDirection.normalize().y*16;
        
        int numBounce = 0;
        while (map[(int)(testX/40)][(int)((testY-75)/40)] != 'X' && foundDirection == false && numBounce != 2){
          //fill(30,30,30);
          //ellipse(testX,testY,5,5);
          int field=(int) map[(int)(testX/40)][(int)((testY-75)/40)];
          int bf=0;
          if (field>48 && field<58) {
            bf=field-48;
          }
          if (field>96 && field<106) {
            bf=field-96;
            bf=-bf;
          }
          if (curProj == 'p') {
            PVector B=new PVector(0, 0, bf*0.009);
            if (bf!=0) {
              PVector a=testDirection.normalize().mult(3).cross(B)
                .mult(1)
                .div(2);
              testDirection.add(a);
            }
            testX+=testDirection.x;
            //println("testx:"+testX);
            //println("testy:"+testY);
            if (map[(int)((testX-5)/40)][(int)((testY-75)/40)]=='X'||map[(int)((testX+5)/40)][(int)((testY-75)/40)]=='X') {
              testX-=testDirection.x;
              testDirection.x= -testDirection.x;
              testDirection.mult(0.53);
              numBounce++;
            }
            testY+=testDirection.y;
            if (map[(int)(testX/40)][(int)((testY-70)/40)]=='X'||map[(int)(testX/40)][(int)((testY-80)/40)]=='X') {
              testY-=testDirection.y;
              testDirection.y= -testDirection.y;
              testDirection.mult(0.53);
              numBounce++;
            }
          } else if (curProj == 'e') {
            PVector B=new PVector(0, 0, bf*0.009);
            if (bf!=0) {
              PVector a=testDirection.normalize().mult(3.5).cross(B)
                .mult(-1)
                .div(0.5);
              testDirection.add(a);
            }
            testX+=testDirection.x;
            if (map[(int)((testX-5)/40)][(int)((testY-75)/40)]=='X'||map[(int)((testX+5)/40)][(int)((testY-75)/40)]=='X') {
              testX-=testDirection.x;
              testDirection.x= -testDirection.x;
              testDirection.mult(0.53);
              numBounce++;
            }
            testY+=testDirection.y;
            if (map[(int)(testX/40)][(int)((testY-70)/40)]=='X'||map[(int)(testX/40)][(int)((testY-80)/40)]=='X') {
              testY-=testDirection.y;
              testDirection.y= -testDirection.y;
              testDirection.mult(0.53);
              numBounce++;
            }
          }
          if (dist(testX,testY,player.x,player.y)<10){
            foundDirection = true;
          }
        }
      }
      if (foundDirection) {
        if (curProj == 'p') {
          allProjectiles.add(new Proton(this.x+bulletDirection.normalize().x*16, this.y+bulletDirection.normalize().y*16, 
            bulletDirection.normalize().mult(3), id));
        } else if (curProj == 'e') {
          allProjectiles.add(new Electron(this.x+bulletDirection.normalize().x*11, this.y+bulletDirection.normalize().y*11, 
            bulletDirection.normalize().mult(3.5), id));
        }
      }
      shootingCounter = 10;
    }
  }

  public void move() {
    super.move();
    shoot(x+random(10)-5, y+random(10)-5);
    movementCounter--;

    if (movementCounter == 0) {
      //println(nextX+","+nextY);
      boolean hasChosen = false;
      while (hasChosen == false) {
        nextX = x + random(300) - 150;
        nextY = y + random(300) - 150;
        if (nextX < 20 || nextX > 1150 || nextY < 95 || nextY > 655) {
          continue;
        }
        if (map[(int)(nextX/40)][(int)((nextY-75)/40)] != 'X' && map[(int)(nextX/40)][(int)((nextY-75)/40)] != 'O') {
          hasChosen = true; 
          movementCounter = (int) (random(40) + 30);
        }
      }
    }
    if (abs(x-nextX) > 10) {
      if (x < nextX) {
        right = 1;
        left = 0;
      }
      if (x > nextX) {
        right = 0;
        left = 1;
      }
    }
    if (abs(y-nextY) > 10) {
      if (y < nextY) {
        up = 0;
        down = 1;
      }
      if (y > nextY) {
        up = 1;
        down = 0;
      }
    } else {
      up = 0;
      down = 0;
      left = 0;
      right = 0;
    }
  }
}
