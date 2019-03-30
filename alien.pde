////--------------------------------------------------------------------------------------------------------------------
////"Class Alien" was placed in main tab as it was too laggy as a separate class tab.
//class Alien { 
//  float xpos; 
//  float true_xpos; 
//  float true_ypos; 
//  float ypos; 
//  float xspeed; 
//  float d; 
//  float r; 
//  boolean imaDeadAlien=false; 

//  Alien(float xpos_, float ypos_, float xspeed_) { 
//    xpos = xpos_; 
//    ypos = ypos_; 
//    xspeed = xspeed_;
//  } 

//  void display() { 
//    noStroke(); 
//    r=40; 
//    true_xpos=xpos+150; 
//    true_ypos=ypos+150; 

//    image(alien, true_xpos, true_ypos, r, r);
//    imageMode(CENTER);
//    //ellipse(true_xpos, true_ypos, r, r);
//  } 

//  void destroyed() { 
//    imaDeadAlien=true;
//  } 

//  void exitStageLeft() { 
//    if (imaDeadAlien==true) { 
//      xpos=-2000; 
//      xspeed=0;
//    }
//  }
//} 