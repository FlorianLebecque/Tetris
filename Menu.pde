

button play = new button();
button btSound = new button();
button btDisp = new button();
button btDark = new button();

PImage SoundOn;
PImage SoundOFF;

PImage SeeON;
PImage SeeON2;
PImage SeeOFF;

PImage LightON;
PImage LightOFF;

void Menu() {

  showGame();
  fill(20, 20, 22, 150);
  rect(offsetX, offsetY, tetroWidth*10, tetroWidth*20);
  fill(244, 78, 66);
  textAlign(CENTER, CENTER);
  textSize(height/6);
  text("TETRIS", width/2, height/3);
  fill(244, 78, 66);
  textSize(height/50);
  text("Lebecque Florian's Creation", 3*width/4, 7.9*height/8);

  play.show();
  btSound.show();
  btDisp.show();
  btDark.show();
}


void newGame() {
  score = 0;
  level=0;
  lost = false;
  speed=48;
  gameSpeed=48;
  tetro = tetromino[next];
  x=3;
  y = -2;
  next = floor(random(0, 7));
  for (int i = 0; i<10; i++) {
    for (int j = 0; j<20; j++) {
      GameTable[i][j] = 0;
    }
  }
  ScreenState = 1;

  if (is_sound) {
    Place.play();
    TetrisMusic = new SoundFile(this, "music.wav");
    TetrisMusic.loop();
  }
}


void btSound_click() {
  is_sound = !is_sound;
  if (is_sound) {
    btSound.texture = SoundOn;
  } else {
    btSound.texture = SoundOFF;
  }
  saveSetup();
}
void btDisp_click() {
  is_zone +=1;
  if (is_zone==1) {
    btDisp.texture = SeeON;
  }else if(is_zone==2){
     btDisp.texture = SeeON2;
  }else {
    btDisp.texture = SeeOFF;
    is_zone=0;
  }
  
  
  saveSetup();
}

void btDark_click() {
  is_dark = !is_dark;
  if (is_dark) {
    btDark.texture = LightOFF;
    grid = color(36, 38, 51);
    back = color(20, 20, 22);
  } else {
    btDark.texture = LightON;
    grid = color(200,200,220);
    back = color(211, 211, 226);
  }
  saveSetup();
}
