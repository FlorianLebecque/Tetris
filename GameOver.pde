button btMenu = new button();

void GameOver() {


  showGame();
  fill(20, 20, 22, 150);
  rect(offsetX, offsetY, tetroWidth*10, tetroWidth*20);

  fill(244, 78, 66);
  textAlign(CENTER);
  textSize(height/11);
  text("GAME OVER", width/2, height/3);

  btMenu.show();
  
  fill(244, 78, 66);
  text("Score : "+score, width/2, height/2+3*height/20);
  text("Level : "+level, width/2, height/2+4*height/20);
  text("HIGHSCORE : "+HIGHSCORE, width/2, height/2+6*height/20);
}

void GameOverMousePressed() {
  if (is_sound) {
    Place.play();
  }

  ScreenState = 0;
}
