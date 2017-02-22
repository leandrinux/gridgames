Conway conway;

void setup() 
{
  size(960, 600, P2D);
  pixelDensity(2);
  smooth(10);
  frameRate(15);
  
  conway = new Conway(95,60);
  conway.cellStyle = CellStyle.Circle;
  conway.backgroundColor = color (0x00, 0x63, 0xFF, 0xFF);
  conway.foregroundColor = color (0x46, 0xEC, 0xC8, 0xFF);
  conway.mutationLevel = 8;
  
  color colors[] = new color[4];
  colors[0] = color(0xff,0,0);
  colors[1] = color(0,0xff,0);
  colors[2] = color(0,0,0xff);
  colors[3] = color(0xff,0xff,0xff);
  conway.cornerColors = colors;
  conway.colorStyle = ColorStyle.Gradient;
}

void draw() 
{
  conway.draw();
}