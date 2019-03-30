class Bullet { 
  //VARIABLES 
  float xpos; //x-position
  float ypos; //y-position
  float yspeed; //speed of bullet

  Bullet(float ingame_xpos, float ingame_ypos, float ingame_yspeed) { 
    xpos = ingame_xpos; 
    ypos = ingame_ypos; 
    yspeed = ingame_yspeed;
  } 

  void display() {
    fill(#FAF551);
    rect(xpos, ypos, 6, 15);
  } 

  void fire() { 
    ypos=ypos-yspeed;
  } 

  boolean finished() { 
    if (ypos-yspeed < 50 || ypos-yspeed > 950) return true; 
    else return false;
  } 

  boolean intersect(Alien a) { 
    float distance = dist(xpos, ypos, a.ingame_xpos, a.ingame_ypos); 
    if (distance < 20) { 
      return true;
    } else { 
      return false;
    }
  }
} 