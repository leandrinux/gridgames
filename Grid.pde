enum CellStyle {
  Rectangle, Circle, Hexagon
}

enum ColorStyle {
  Solid,
  Gradient
}

class Grid 
{
  PGraphics pg;
  
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
  
  Grid(int boardWidth, int boardHeight, int defaultValue) {    
    this.boardWidth = boardWidth;
    this.boardHeight = boardHeight;
    this.defaultValue = defaultValue;
    pg = createGraphics(width, height);
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
        float hueE = ( hue(B)*i/a + hue(A)*(1-i/a) ) * (j/a)  +  ( hue(D)*i/a + hue(C)*(1-i/a) ) * (1-j/a);
        colorMode(HSB, 100);
        return color(hueE, 50, 100);
      }
    }
  }
  
  void draw() {
    
    pg.beginDraw();
    
    pg.clear();
    if (alpha(backgroundColor) != 0) {
      pg.background(backgroundColor);
    }
    pg.noStroke();    
    pg.rectMode(CORNERS);
    pg.ellipseMode(CORNERS);

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
        
        pg.fill(colorForCellAt(i,j));
        
        switch(cellStyle) {
          case Rectangle:
            pg.rect(x, y, nx, ny);
            break;
          case Circle:
            pg.ellipse(x, y, nx, ny);
            break;
          case Hexagon: {
            x = int(x + cellWidth/2*j);
            if (i % 2 == 1) {
              x = int(x + (3*cellWidth/4));
            }
            y = int(y - i*cellHeight/2);
            hexagon(x, y, cellWidth, cellHeight);
            break;
          }
          
        }
        
      }
    }
    
    pg.endDraw();
  }
    
  private void hexagon(float x1, float y1, float w, float h) {
    float x2 = x1 + w;
    float y2 = y1 + h;
    pg.beginShape();
    pg.vertex(x1 + 0    , y1 + h/2);
    pg.vertex(x1 + w/4  , y1 + 0);
    pg.vertex(x1 + 3*w/4, y1 + 0);
    pg.vertex(x1 + w    , y1 + h/2);
    pg.vertex(x1 + 3*w/4, y1 + h);
    pg.vertex(x1 + w/4  , y1 + h);
    pg.endShape(CLOSE);    
  }
}