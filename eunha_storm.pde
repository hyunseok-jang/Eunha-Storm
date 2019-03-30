/* ICS3U CULMINATING 
 Description: A great game to improve one's Galaga/Space Invaders aim skills
 Author: Peter Jang
 Date of last edit: Jan 19, 2018
 */

//VARIABLES 
int page; //for page directory

Spaceship mySpaceship; //for fighter
ArrayList bullets; //array for bullets

int column = 14; //column variable for bullets & aliens
int row = 10; //row variable for bullets & aliens
int column_select; //column variable for bullets & aliens
int row_select; //row variable for bullets & aliens

int begin; //when to start the timer
int duration1st; //the duration of the timer
int duration2nd; //the duration of the timer
int time1stcountdown; //countdown for 5 sec
int time2ndcountdown; //countdown for in-game (45sec)

Alien[][] aliens = new Alien[column][row]; //array for aliens - column/row

//boolean gameOn=true; 

int deadAliens=0; //for dead aliens
int lastGuy=0; //for last remaining alien

int stars = 1000; //array for star background
int[] starSpeed = new int [stars]; //array for star background
int[] x = new int [stars]; //array for star background
int[] y = new int [stars]; //array for star background

PImage background; //PImage for background
PImage title; //PImage for title
PImage name; //PImage for name
PImage alien; //PImage for aliens
PImage startgame; //PImage for startgame
PImage help; //PImage for help screen
PImage helpp; //PImage for help page
PImage nicetry; //PImage for help screen
PImage nice; //PImage for help page

void setup() {
  fullScreen(); //fullscreen mode
  page = 1;

  //for star background
  for (int i = 0; i < stars; i++) {
    x[i] = int(random(0, width));
    y[i] = int(random(0, height));
    starSpeed[i] = int(random(5, 5));
  }

  //images
  //load alien image for "Class Alien" - did this in void setup() as loading it up in-class was too laggy
  background = loadImage("background.jpg");
  name = loadImage("name.png");
  alien = loadImage("enemy.png");
  title = loadImage("title.png");
  startgame= loadImage ("start game.png");
  help = loadImage ("help.png");
  helpp = loadImage ("helpp.jpg");
  nicetry = loadImage ("nicetry.JPG");
  nice = loadImage ("nice.JPG");

  //to initialize the fighter
  //constructor
  mySpaceship = new Spaceship(width/2, height*90/100);

  //to initialize the array for bullets
  bullets = new ArrayList(); 

  //to initialize the array for aliens 
  for (int i = 0; i< column; i++) { 
    for (int j = 0; j<row; j++) { 
      aliens[i][j] = new Alien(i*125, j*80);
    }
  }

  //to initialize the timers
  begin = millis();
  time1stcountdown = duration1st = 5; //1st countdown timer = 5 sec long
  time2ndcountdown = duration2nd = 40; //2nd countdown (in-game) timer = 45 - 5 = 40 sec long
}

void draw() {

  //coordinate indicator
  println (mouseX +"," + mouseY);
  if (page == 1) { //title page
    image(background, 0, 0);
    imageMode(CENTER);
    image(title, width/2, 300);
    image(name, width/2, 1000);
    //Start game button
    float x1 = 752;
    float y1 = 505;
    float w1 = 412;
    float h1 = 61;
    image(startgame, width/2, height/2, 400, 50);

    if (mousePressed)
    {
      if (mouseX>x1 && mouseX <x1+w1 && mouseY>y1 && mouseY <y1+h1)
      {
        println("start game button is pressed");
        page = 2;
      }
    }

    //help button
    float x2 = 880;
    float y2 = 616;
    float w2 = 150;
    float h2 = 54;
    image(help, width/2, 650, 150, 50);

    if (mousePressed)
    {
      if (mouseX>x2 && mouseX <x2+w2 && mouseY>y2 && mouseY <y2+h2)
      {
        println("help button is pressed");
        page = 6;
      }
    }
  } 

  // countdown page
  if (page==2) {
    image(background, 0, 0);
    //1stpage countdown timer
    if (time1stcountdown > 0)  time1stcountdown= duration1st - (millis() - begin)/1000;
    if (time1stcountdown <= 0) { 
      page = 3;
    }
    //countdown timer (in-game)
    fill(#FAF551);
    textAlign(CENTER);
    textSize(150);
    text(time1stcountdown, width/2, height/2);
  }

  //Start Game Page
  if (page==3) {
    background(0); //black background

    //for star background
    for (int i=0; i<stars; i++) {
      fill(255);
      rect(x[i], y[i], 2, 2);
    }
    for (int i=0; i<stars; i++) {
      y[i]+= starSpeed[i];
      if (y[i] > height) {
        y[i] = 0;
      }
    }

    //2ndpage countdown timer(40sec)
    if (time2ndcountdown > 0)  time2ndcountdown= duration2nd - (millis() - begin)/1000;
    if (time2ndcountdown <= 0) { 
      page = 4;
    }

    //countdown timer (in-game)
    textSize(50);
    textAlign(LEFT);
    text(time2ndcountdown, 160, 80);
    text("TIME:", 20, 80);

    //kill count (in-game)
    textSize(50);
    text(deadAliens, 450, 80);
    text("KILLED:", 250, 80);

    //if the user kills all 140 aliens -> congratulations page
    if (deadAliens >= 140) {
      page = 5;
    }

    //from class fighter
    mySpaceship.keyPressed();//keyboard control for fighter
    mySpaceship.display(); //to display the fighter
    mySpaceship.lastGuy(); //last enemy remaining 

    //for aliens
    for (int i = 0; i < column; i++) { 
      for (int j = 0; j < row; j++) { 
        aliens[i][j].display(); 
        aliens[i][j].exitStageLeft();
      }
    }

    //for bullets
    for (int i = 0; i < bullets.size(); i++) { 
      Bullet b = (Bullet) bullets.get(i); 
      b.display(); 
      b.fire(); 
      if (b.finished()) { 
        bullets.remove(b);
      } 
      for (int k = 0; k < column; k++) { 
        for (int j = 0; j < row; j++) { 
          if (b.intersect(aliens[k][j])) { 
            bullets.remove(b); 
            aliens[k][j].destroyed(); 
            deadAliens=deadAliens+1;
          }
        }
      }
    }
  }

  //try again page
  if (page == 4) {
    image(nicetry, width/2, height/2, width, height);
    textSize(150);
    text(deadAliens, 822, 600);
    textSize(50);
    textAlign(LEFT);
    text("Press TAB to Restart", 450, 80);
  }

  //congratulations page 
  if (page == 5) {
    image(nice, width/2, height/2, width, height);
    text("Press TAB to Restart", 450, 80);
  }

  // Help! Page
  if (page==6) {
    image(helpp, width/2, height/2, width, height);
    fill(#FAF551);
    textSize(60);
    textAlign(CENTER);
    text("Press TAB to Go Back", 450, 80);
  }
}


//mouse control - shooting bullets
void mousePressed() { 
  bullets.add(new Bullet(mySpaceship.xpos, 880, 10));
} 

//keyboard control - returning to menu/resetting program
void keyPressed() {
  //for returning to menu
  if (key == TAB) {
    setup();
  }
}


//--------------------------------------------------------------------------------------------------------------------
//"Class Alien" was placed in main tab as it was too laggy as a separate class tab.
class Alien {
  //VARIABLES 
  float xpos; //x-position
  float ingame_xpos; //x-position in-game
  float ingame_ypos; //y-position in-game
  float ypos; //y-position
  float xspeed; //speed the aliens fade away when shot
  float sizeAlien; //sizing of aliens
  boolean imaDeadAlien=false; 

  Alien(float xpos_, float ypos_) { 
    xpos = xpos_; 
    ypos = ypos_;
  } 

  void display() { 
    sizeAlien=40; 
    ingame_xpos=xpos+150; 
    ingame_ypos=ypos+150; 

    image(alien, ingame_xpos, ingame_ypos, sizeAlien, sizeAlien);
    imageMode(CENTER);
  } 

  void destroyed() { 
    imaDeadAlien=true;
  } 

  void exitStageLeft() { 
    if (imaDeadAlien==true) { 
      xpos=-2000; //move it out of the window when shot 
      xspeed=6000; //move it out of the window when shot ASAP
    }
  }
} 