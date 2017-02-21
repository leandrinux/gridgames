class Grid 
{
  protected int boardWidth        = 0;
  protected int boardHeight       = 0;
  protected int defaultValue      = 0;
  protected int cells[][]; 
  
  int   spacing         = 1;
  color backgroundColor = color(0xFF,0xFF,0xFF, 0xFF);
  color foregroundColor = color(0x00,0x00,0xFF);
  
  Grid(int width, int height, int defaultValue) {
    boardWidth = width;
    boardHeight = height;
    this.defaultValue = defaultValue;
    initCells();
  }
  
  protected void initCells() {
    cells = new int[boardWidth][boardHeight];
    for (int j=0 ; j < boardWidth ; j++)
      for (int i=0 ; i < boardHeight ; i++)
        cells[j][i] = defaultValue;
  }
  

  protected PImage imageForCellAt(int i, int j) {
    PImage image = new PImage();
    return image;
  }
  
  void draw() {
    
    background(backgroundColor);
    
    for (int j=0 ; j < boardWidth ; j++) {
      for (int i=0 ; i < boardHeight ; i++) {
        PImage img = imageForCellAt(i,j);
        int x = int(j * img.width + (j * spacing));
        int y = int(i * img.height + (i * spacing));        
        image(img, x, y);
      }
    }

  }
  
}