final class Conway extends Grid {
  
  Conway(int width, int height) {
    super(width, height, false);
  }
  
  protected void initCells() {
    cells = new Boolean[boardWidth][boardHeight];
    for (int j=0 ; j < boardWidth ; j++)
      for (int i=0 ; i < boardHeight ; i++)
        cells[j][i] = random(1)<0.5;
  }
  
  protected color colorForCellAt(int i, int j) {
    float a = float(i+j) * 0xFF / float(boardWidth+boardHeight);
    return color(0, a, 0);
  }
  
  void draw() {
    lifeCycle();
    super.draw();
  }
      
  private void lifeCycle() {
    Boolean boardNext[][] = new Boolean[boardWidth][boardHeight];
    
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
              cells[x+dx][y+dy]
            ) {
              n++;
            }
          }  
        }
        Boolean c = cells[x][y];
        switch (n) {
          case 0:
          case 1:
            c = false;
            break;
          case 2:
            break; 
          case 3:
            c = true;
            break;
          default:
            c = false;
        }
        boardNext[x][y] = c;
      }
    }
    
    cells = boardNext;      
  }

}