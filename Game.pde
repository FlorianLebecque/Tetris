void Game() {
  CorrectPos(2);
  state+=1;

  if (state==speed) {
    state=0;
    y+=1;
  }

  showGame();
  showTetros();

  fill(183, 44, 44);
  for (int i =0; i<tetromino[next].length; i++) {
    for (int j = 0; j<tetromino[next].length; j++) {
      if (tetromino[next][i][j]==1) {
        rect(offsetX-tetroWidth+(i*tetroWidth/2), offsetY-(tetroWidth*3)+(j*tetroWidth/2), tetroWidth/2, tetroWidth/2);
      }
    }
  }

  textAlign(CENTER);
  textSize(height/32);
  text("Level : "+level+" score : "+score, width/2, offsetY-tetroWidth/3);
}

void GameMousePressed() {
  if (mouseY <= (height/2)) {
    Rotation();
    zone1 = 50;
  } else if (mouseY <= 4*(height/5)) {
    if (mouseX <= width/2 ) {
      x-=1;
      CorrectPos(-1);
      zone2 = 50;
    } else {
      x+=1;
      CorrectPos(1);
      zone3 = 50;
    }
  } else if (mouseY > 4*(height/5)) {
    speed = 1;
    state = 0;
    zone4 = 50;
  }
}
