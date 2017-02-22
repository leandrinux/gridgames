Conway conway;

void setup() 
{
  size(960, 600, P2D);
  pixelDensity(2);
  frameRate(15);
  
  conway = new Conway(95,60);
  conway.cellStyle = CellStyle.Circle;
  conway.backgroundColor = color (0x00, 0x63, 0xFF, 0xFF);
  conway.foregroundColor = color (0x46, 0xEC, 0xC8, 0xFF);
  conway.mutationLevel = 6;
}

void draw() 
{
  conway.draw();
}