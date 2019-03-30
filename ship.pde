class Spaceship { 
  //VARIABLES
  PImage fighter; //PImage for fighter
  float xpos; //x-position
  float ypos; //y-position

  //constructor 
  Spaceship(float ingame_xpos, float ingame_ypos) { 
    xpos = ingame_xpos; 
    ypos = ingame_ypos;
  } 

  void display() { 
    noStroke(); 
    fighter = loadImage("fighter.png");
    image(fighter, xpos, ypos, 70, 70);
  } 

  void keyPressed() {
    if (key == CODED) {
      switch(keyCode) {
      case LEFT: 
        xpos -= 5;
        if (xpos < 0) {
          xpos = width;
        } 
        break;
      case RIGHT:
        xpos += 5;
        if (xpos > width)
        {
          xpos = 0;
        }
        break;
      }
    }
  }

  void lastGuy() { 
    println(deadAliens); 
    if (deadAliens==49) { 
      lastGuy=1000;
    } else { 
      lastGuy=0;
    }
  }
} 