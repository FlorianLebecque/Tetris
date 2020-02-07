
//game table
int[][] tetro;
int[][] GameTable = new int[10][20];

//game properties
int tetroWidth = 0;
int next = 0;
float gameSpeed = 48;
float speed = 48;
float state = 0;

boolean touched = false;
boolean lost = false;

//position of tetromino
int x = 3;
int y = -2;
int level = 0;
int score = 0;

//graphic offset
float offsetX = 0;
float offsetY = 0;


void checkRow() {
  boolean has_been_clear = true;
  int count = 0;
  while (has_been_clear) {
    has_been_clear = false;
    for (int j=19; j>-1; j--) {
      int total = 0;
      for (int i = 0; i<10; i++) {
        total += GameTable[i][j];
      }

      if (total == 10) {
        if (is_sound) {
          explode.play();
        }
        for (int i = 0; i<10; i++) {
          GameTable[i][j]=0;
        }
        //make thing fall
        for (int k = j; k>0; k--) {
          for (int l = 0; l<10; l++) {
            GameTable[l][k] = GameTable[l][k-1];
          }
        }

        has_been_clear = true;
        count +=1;
      }
    }
  }

  int scoretoadd=0;
  switch(count) {
  case 1: 
    scoretoadd = 40 * (level+1);
    break;
  case 2: 
    scoretoadd = 100 * (level+1);
    break;
  case 3: 
    scoretoadd = 300 * (level+1);
    break;
  case 4: 
    scoretoadd = 1000 * (level+1);
    break;
  }



  score += scoretoadd;
}

void showTetros() {
  //rect(offsetX+(x*tetroWidth),offsetY+(y*tetroWidth),tetroWidth*4,tetroWidth*4);
  for (int i = 0; i<tetro.length; i++) {
    for (int j = 0; j<tetro.length; j++) {
      if ((tetro[i][j]==1)&&(y+j>-1)) {
        int r = floor(map(y+j, 0, 19, 100, 183));
        fill(r, 44, 44);
        rect(offsetX+(x+i)*tetroWidth, offsetY+(y+j)*tetroWidth, tetroWidth, tetroWidth);
      }
    }
  }
}
void showGame() {

  for (int i = 0; i<10; i++) {
    for (int j = 0; j<20; j++) {
      if (GameTable[i][j]==0) {
        stroke(20, 20, 22);
        fill(grid);
      } else {
        noStroke();
        int g = floor(map(i, 0, 9, 100, 193));
        int b = floor(map(j, 0, 19, 50, 100));
        fill(46, g, b);
      }
      rect(offsetX+i*tetroWidth, offsetY+j*tetroWidth, tetroWidth, tetroWidth);
    }
  }
}

void CorrectPos(int dir) {
  for (int i = 0; i<tetro.length; i++) {
    for (int j = 0; j<tetro.length; j++) {
      if (tetro[i][j]==1) {
        if (i+x < 0) {  //ne sort pas a gauche
          x += 0-(x+i);
        }
        if (i+x > 9) {  //new sort pas a droite
          x -= (x+i)-9;
        }
        if ((i+x >= 0) &&(i+x<=9)&&(j+y >=0)&&(j+y<=19)) {
          if (GameTable[i+x][j+y]==1) {
            if (dir != 2) {
              x-=dir;
            } else {
              touched = true;
            }
          }
        }

        if (j+y>19) {
          touched = true;
        }
      }
    }
  }

  if (touched) {
    level = setlevel();
    if (is_sound) {
      Place.play();
    }
    y-=1;
    for (int i = 0; i<tetro.length; i++) {
      for (int j = 0; j<tetro.length; j++) {
        if ((i+x >= 0) &&(i+x<=9)&&(j+y >=0)&&(j+y<=19)) {
          if (tetro[i][j]==1) {
            GameTable[i+x][j+y] = tetro[i][j];
          }
        }
      }
    }
    if (y<0) {
      if(score>HIGHSCORE){
        HIGHSCORE = score;
        saveSetup();
      }
      lost = true;
      musicStarted = false;
      TetrisMusic.stop();
      ScreenState = 2;
    }
    touched =false;
    y=-2;
    x = 3;
    tetro = tetromino[next];
    next = floor(random(0, 7));
    if(!lost){
      if (speed==1) {  //hard drop
      score += 8*(level+1);
      } else {  //soft drop
        score += 4*(level+1);
      }
      speed=gameSpeed;
    }
   
    checkRow();
  }
}

void Rotation() {
  boolean possible = false;
  int tried = 0;
  int[][] temp = tetro.clone();

  while ((!possible)&&(tried <4)) {
    temp = Rotate(temp);
    //CorrectPos(2);
    possible = true;
    for (int i = 0; i<tetro.length; i++) {
      for (int j = 0; j<tetro.length; j++) {
        if ((i+x >= 0) &&(i+x<=9)&&(j+y >=0)&&(j+y<=19)) {
          if (temp[i][j] + GameTable[i+x][j+y]==2) {
            possible =false;
          }
        }
      }
    }
    tried +=1;
  }

  if (possible) {
    tetro = temp;
  }
}

int[][] Rotate(int [][] m1) {
  //https://www.geeksforgeeks.org/inplace-rotate-square-matrix-by-90-degrees/
  int a = m1.length;
  int[][] result = new int[a][a];
  int N = a;
  // Consider all squares one by one
  for (int x = 0; x < N / 2; x++)
  {
    // Consider elements in group of 4 in 
    // current square
    for (int y = x; y < N-x-1; y++)
    {

      // move values from right to top
      result[x][y] = m1[y][N-1-x];

      // move values from bottom to right
      result[y][N-1-x] = m1[N-1-x][N-1-y];

      // move values from left to bottom
      result[N-1-x][N-1-y] = m1[N-1-y][x];

      // assign temp to left
      result[N-1-y][x] = m1[x][y];
    }
  }
  
  if(a==3){
    result[1][1]= 1;
  }

  return result;
}

int setlevel() {

  if (score > (exp(0.6*(level))*1200)) {
    if (is_sound) {
      levelUp.play();
    }
    level+=1;
    gameSpeed = setSpeed();
    speed=gameSpeed;
  }
  return level;
}

int setSpeed() {
  int fps = 0;

  if (level == 1) {
    fps =43;
  } else if (level == 2) {
    fps = 38;
  } else if (level == 3) {
    fps = 33;
  } else if (level == 4) {
    fps = 28;
  } else if (level == 5) {
    fps = 23;
  } else if (level == 6) {
    fps = 18;
  } else if (level == 7) {
    fps = 13;
  } else if (level == 8) {
    fps =8;
  } else if (level == 9) {
    fps =6;
  } else if (level <= 10) {
    fps = 5;
  } else if (level <= 15) {
    fps = 4;
  } else if (level <= 18) {
    fps = 3;
  } else if (level <= 28) {
    fps = 2;
  } else {
    fps = 1;
  }

  return fps;
}
