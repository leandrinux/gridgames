enum CellStyle {
  Rectangle, Circle
}

enum ColorStyle {
  Solid,
  Gradient
}

class Grid 
{
  protected int boardWidth        = 0;
  protected int boardHeight       = 0;
  protected int defaultValue      = 0;
  protected int cells[][]; 
  
  int         spacing         = 1;
  CellStyle   cellStyle       = CellStyle.Rectangle;
  ColorStyle  colorStyle      = ColorStyle.Solid;
  color       backgroundColor = color(0x00,0x00,0x00, 0xFF);
  color       foregroundColor = color(0x00,0x00,0xFF);
  color       cornerColors[];
  
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
      if (colorStyle == ColorStyle.Solid) {
        return foregroundColor;
      } else {
        color A = cornerColors[0];
        color B = cornerColors[1];
        color C = cornerColors[2];
        color D = cornerColors[3];
        float a = boardWidth;
        //float b = boardHeight;
        float hueE = ( hue(B)*i/a + hue(A)*(1-i/a) ) * (j/a)  +  ( hue(D)*i/a + hue(C)*(1-i/a) ) * (1-j/a);
        return color(hueE, 50, 100);
      }
    }
  }
  
  void draw() {
    
    background(backgroundColor);
    noStroke();    
    rectMode(CORNERS);
    ellipseMode(CORNERS);

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
        
        
        if (colorStyle == ColorStyle.Solid)
          colorMode(RGB);
        else
          colorMode(HSB, 100);
          
        fill(colorForCellAt(i,j));
        
        if (cellStyle == CellStyle.Rectangle) {
          rect(x, y, nx, ny);
        } else {
          ellipse(x, y, nx, ny);
        }
        
      }
    }

  }
  
}