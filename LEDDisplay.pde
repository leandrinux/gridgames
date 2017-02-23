enum LEDDisplayDirection {
  None,
  Left,
  Right,
  Up,
  Down
}

class LEDDisplay extends Grid
{
  color activeColor;
  color inactiveColor;
  
  LEDDisplayDirection direction;
  
  int[] pendingColumn;
  int[] zeroColumn;
  int   everyFrames = 2;
  
  LEDDisplay(int imageWidth, int imageHeight, int boardWidth, int boardHeight) {
    super(imageWidth, imageHeight, boardWidth, boardHeight, 0);
    cellStyle = CellStyle.Circle;
    spacing = 2;
    backgroundColor = color(0x0A,0x0A,0x0A,0x00); 
    activeColor = color(0xFF,0xFF,0xFF);
    inactiveColor = color(0x20,0x20,0x20);
    direction = LEDDisplayDirection.Left;

    zeroColumn = new int[boardHeight];
    for (int i=0;i<boardHeight;i++) {
      zeroColumn[i] = 0;
    }

    pendingColumn = zeroColumn;
  }
  
  protected color colorForCellAt(int i, int j) {
    if (cells[j][i] == 0) 
      return inactiveColor;
    else
      return activeColor;
  }
  
  void draw() {
    if (cycleCount % everyFrames == 0) {
      switch (direction) {
        case Left:
          pushFromRight();
        default:
          break;
      }
    }
    super.draw();
  }
  
  void pushFromRight() 
  {
    if (pendingColumn.length != boardHeight) {
      print("Pushed a column with a height different than ", boardHeight);
      exit();
    }
        
    for (int j=1;j<boardWidth;j++) {
      for (int i=1;i<boardHeight;i++) {
        cells[j-1][i] = cells[j][i];
      }
    }
    
    for (int i=0;i<boardHeight;i++) {
      cells[boardWidth-1][i] = pendingColumn[i];  
    }
    
    pendingColumn = zeroColumn;
    
  }

}