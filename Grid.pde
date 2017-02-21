class Grid 
{
  protected int boardWidth        = 0;
  protected int boardHeight       = 0;
  protected int defaultValue      = 0;
  protected int cells[][]; 
  
  int   spacing         = 1;
  color backgroundColor = color(0x00,0x00,0x00, 0xFF);
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
  
  protected color colorForCellAt(int i, int j) {
    if (cells[j][i] == 0) {
      return color(1, 1, 1, 0);
    } else {
      float a = float(j) * 0xFF / float(boardWidth);
      float b = float(i) * 0xFF / float(boardHeight);
      return color(b, a, b);
    }
  }
  
  void draw() {
    
    background(backgroundColor);
    noStroke();    
    rectMode(CORNERS);

    float totalHSpacing = (boardWidth - 1) * spacing;
    float totalVSpacing = (boardHeight - 1) * spacing;
    float cellWidth = (width - totalHSpacing) / boardWidth;
    float cellHeight = (height - totalVSpacing) / boardHeight;
        
    for (int j=0 ; j < boardWidth ; j++) {
      for (int i=0 ; i < boardHeight ; i++) {
        
        int x = int(j * cellWidth + (j * spacing));
        int y = int(i * cellHeight + (i * spacing));
        int nx = int(x + cellWidth);
        int ny = int(y + cellHeight);
        
        fill(colorForCellAt(i,j));        
        rect(x, y, nx, ny);
      }
    }

  }
  
}