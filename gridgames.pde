Conway conway;

void setup() 
{
  size(960, 600, P2D);
  pixelDensity(2);
  frameRate(15);
  
  conway = new Conway(150,100);
  conway.cellStyle = CellStyle.Circle;
}

void draw() 
{
  conway.draw();
}