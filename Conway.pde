final class Conway extends Grid {
  
  private int cycleCount = 0;
  
  Conway(int width, int height) {
    super(width, height, 0);
  }
  
  protected void initCells() {
    cells = new int[boardWidth][boardHeight];
    for (int j=0 ; j < boardWidth ; j++)
      for (int i=0 ; i < boardHeight ; i++)
        if (random(1)<0.5) {
          cells[j][i] = 255;
        } else {
          cells[j][i] = 0;
        }
        
  }
    
  void draw() {
    mutate();
    lifeCycle();
    super.draw();
  }
  
  private void mutate() {
    int mutations = int(random(50))+10;
    if (cycleCount % 50 == 0) {
      for (int m=0 ; m < mutations ; m++) {
        int j = int(random(boardWidth));
        int i = int(random(boardHeight));
        cells[j][i] = 255;
      }
    }
  }
      
  private void lifeCycle() {
    int boardNext[][] = new int[boardWidth][boardHeight];
    
    for (int x = 0; x < cells.length; x++) {
      for (int y = 0; y < cells[x].length; y++) {
        int n = 0;
        for (int dx = -1; dx <= 1; dx++) {
          for (int dy = -1; dy <= 1; dy++) {
            if ( dx == 0 && dy == 0){}
            else if (
              x+dx > 0 &&
              x+dx < boardWidth &&
              y+dy > 0 &&
              y+dy < boardHeight &&
              cells[x+dx][y+dy] != 0
            ) {
              n++;
            }
          }  
        }
        int c = cells[x][y];
        switch (n) {
          case 0:
          case 1:
            c = 0;
            break;
          case 2:
            break; 
          case 3:
            c = 255;
            break;
          default:
            c = 0;
        }
        boardNext[x][y] = c;
      }
    }
    
    cells = boardNext;
    cycleCount++;
  }

}