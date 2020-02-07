int[][] tetroI = {
  {0, 0, 1, 0}, 
  {0, 0, 1, 0}, 
  {0, 0, 1, 0}, 
  {0, 0, 1, 0}
};
int[][] tetroO ={
  {0, 0, 0, 0}, 
  {0, 1, 1, 0}, 
  {0, 1, 1, 0}, 
  {0, 0, 0, 0}
};
int[][] tetroT= {
  {0, 0, 0},
  {1, 1, 1}, 
  {0, 1, 0} 
};
int[][] tetroL= {
  {0, 0, 0}, 
  {1, 1, 1}, 
  {1, 0, 0}
};
int[][] tetroJ= {
  {0, 0, 0}, 
  {1, 1, 1}, 
  {0, 0, 1}
};
int[][] tetroZ = { 
  {1, 1, 0}, 
  {0, 1, 1}, 
  {0, 0, 0}
};
int[][] tetroS = { 
  {0, 1, 1}, 
  {1, 1, 0}, 
  {0, 0, 0}
};

int[][][] tetromino = {
  tetroI, 
  tetroO, 
  tetroT, 
  tetroL, 
  tetroJ, 
  tetroZ, 
  tetroS
};
