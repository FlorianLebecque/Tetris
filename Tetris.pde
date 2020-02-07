//import cassette.audiofiles.*;

import processing.sound.*;

void setup() {
  size(720, 1280, P2D);
  //fullScreen(P2D);
  frameRate(60);

  tetro = tetromino[floor(random(0, 7))];
  next = floor(random(0, 7));


  offsetX = width/8;
  offsetY = height/8;
  tetroWidth = (width/8*6)/10;

  TetrisMusic = new SoundFile(this, "music.wav");
  explode = new SoundFile(this, "explode.wav");
  Place = new SoundFile(this, "Place.wav");
  levelUp = new SoundFile(this, "LevelUp.wav");

  play.text = "PLAY";
  play.w = 2.5*(width/4);
  play.x = (width/2)-(play.w/2);
  play.y = 2*(height/4);
  play.h = height/12;

  btMenu.text = "MENU";
  btMenu.w = 2.5*(width/4);
  btMenu.x = (width/2)-(play.w/2);
  btMenu.y = 2*(height/4);
  btMenu.h = height/12;


  btSound.x = play.x;
  btSound.y = play.y + play.h + 4;
  btSound.w = (play.w/2)-2;
  btSound.h = play.h;

  btDisp.x = play.x+btSound.w+4;
  btDisp.y = play.y + play.h + 4;
  btDisp.w = (play.w/2)-2;
  btDisp.h = play.h;


  btDark.w = 2.5*(width/4);
  btDark.x = (width/2)-(play.w/2);
  btDark.y = btDisp.y + btDisp.h + 4;
  btDark.h = height/12;

  File set = new File(dataPath("")+"/setup.txt");
  if (set.exists()) {
    loadSetup();
  } else {
    HIGHSCORE = 0;
    is_sound = true;
    is_zone = 2;
    is_dark = false;
    saveSetup();
  }


  SoundOn = loadImage("Sound_icon_ON.png");
  SoundOFF = loadImage("Sound_icon_OFF.png");
  if (is_sound) {
    btSound.texture = SoundOn;
  } else {
    btSound.texture = SoundOFF;
  }

  LightON = loadImage("Light_ON.png");
  LightOFF = loadImage("Light_OFF.png");
  if (is_dark) {
    grid = color(36, 38, 51);
    back = color(20, 20, 22);
    btDark.texture = LightOFF;
  } else {
    grid = color(200, 200, 220);
    back = color(211, 211, 226);
    btDark.texture = LightON;
  }

  SeeON = loadImage("See_ON.png");
  SeeON2 = loadImage("See_ON2.png");
  SeeOFF = loadImage("See_OFF.png");
  if (is_zone==1) {
    btDisp.texture = SeeON;
  } else if (is_zone==2) {
    btDisp.texture = SeeON2;
  } else {
    btDisp.texture = SeeOFF;
  }
}

SoundFile TetrisMusic;
SoundFile explode;
SoundFile levelUp;
SoundFile Place;

color back;
color grid;

boolean musicStarted =false;
int ScreenState = 0;

boolean is_dark;
boolean is_sound;
int is_zone;
int HIGHSCORE=0;

float zone1 = 0;
float zone2 = 0;
float zone3 = 0;
float zone4 = 0;
void draw() {
  background(back);

  switch(ScreenState) {
  case 0:
    Menu();
    break;
  case 1:
    Game();
    if (is_zone==1) {
      ShowArea();
    }
    if (is_zone==2) {
      ShowArea2();
    }
    break;
  case 2:
    GameOver();
    break;
  }
}

void stop() {
  TetrisMusic.stop();
}


void ShowArea() {
  noStroke();
  fill(66, 244, 89, zone1);
  rect(0, 0, width, height/2);

  fill(66, 244, 89, zone2);
  rect(0, height/2, width/2, (height/2)-(height/5));

  fill(66, 244, 89, zone3);
  rect(width/2, height/2, width, (height/2)-(height/5));

  fill(66, 244, 89, zone4);
  rect(0, 4*(height/5), width, height/5);
}

void ShowArea2() {
  strokeWeight(5);
  stroke(0);
  fill(66, 244, 89, zone1);
  rect(0, 0, width, height/2);

  fill(66, 244, 89, zone2);
  rect(0, height/2, width/2, (height/2)-(height/5));

  fill(66, 244, 89, zone3);
  rect(width/2, height/2, width, (height/2)-(height/5));

  fill(66, 244, 89, zone4);
  rect(0, 4*(height/5), width, height/5);
  noStroke();
  strokeWeight(1);
}

void mousePressed() {
  if (ScreenState == 0) {
    if (play.Is_click()) {
      newGame();
    }
    if (btSound.Is_click()) {
      btSound_click();
    }
    if (btDisp.Is_click()) {
      btDisp_click();
    }
    if (btDark.Is_click()) {
      btDark_click();
    }
  }
  if (ScreenState == 2) {
    if (btMenu.Is_click()) {
      GameOverMousePressed();
    }
  } else {
    GameMousePressed();
  }
}

void mouseReleased() {
  speed = gameSpeed;
  zone1=0;
  zone2=0;
  zone3=0;
  zone4=0;
}

void keyPressed() {
  if (keyCode == UP) {
    Rotation();
  }

  if (keyCode == LEFT) {
    x-=1;
    CorrectPos(-1);
  }
  if (keyCode == RIGHT) {
    x+=1;
    CorrectPos(1);
  }
  if (keyCode == DOWN) {
    speed = 1;
    state = 0;
  }
}
void keyReleased() {
  if (keyCode == DOWN) {
    speed = gameSpeed;
  }
}
