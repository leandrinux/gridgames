final class Conway extends Grid {
  
  private PImage sprites[];
  private PImage emptySprite;
  
  Conway(int width, int height) {
    super(width, height, 0);
    
    // load sprites
    PImage spriteSheet = loadImage("sheet_apple_16_indexed_128.png");
    
    int sW = 16;
    int sH = 16;
    int fromRow = 1;
    int toRow = 5;
    int fromColumn = 4;
    int toColumn = 7;
    
    int size = (toRow - fromRow) * (toColumn - fromColumn);
    sprites = new PImage[size];
    int counter = 0;
    for (int j=fromColumn ; j < toColumn ; j++)
      for (int i=fromRow ; i < toRow ; i++) {
        PImage image = createImage(sW, sH, ARGB);
        image.copy(spriteSheet, j*sW, i*sH, sW, sH, 0, 0, sW, sH);
        sprites[counter] = image;
        counter++;
      }
    emptySprite = createImage(sW, sH, ARGB);
    
  }
  
  protected void initCells() {
    cells = new int[boardWidth][boardHeight];
    for (int j=0 ; j < boardWidth ; j++)
      for (int i=0 ; i < boardHeight ; i++)
        if (random(1)<0.5) {
          cells[j][i] = byte(255);
        } else {
          cells[j][i] = 0;
        }
  }

  protected PImage imageForCellAt(int i, int j) {
    int v = cells[j][i];
    if (v != 0) {
      int index = abs(v) % sprites.length;
      return sprites[index];
    } else {
      return emptySprite;
    }
  }
    
  void draw() {
    lifeCycle();
    super.draw();
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
            c = int(random(500));
            break;
          default:
            c = 0;
        }
        boardNext[x][y] = c;
      }
    }
    
    cells = boardNext;      
  }

}