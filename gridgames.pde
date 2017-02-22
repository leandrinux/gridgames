color colorA = color(0x00,0x63,0xFF,0xFA);
color colorB = color(0x46,0xEC,0xC8,0xFA);
color colorC = color(0xFE,0xFE,0xFE,0xFA);
Conway conways[];

void setup() 
{
  size(960, 600, P2D);
  smooth(10);
  frameRate(15);

  color[] colors = {  colorA, colorB, colorC };
  
  int c = colors.length;
  conways = new Conway[c];
  for (int i=0;i<c;i++) {
    Conway conway = new Conway(95/2,60/2);
    conway.cellStyle = CellStyle.Circle;
    conway.mutationLevel = 4;
    conway.backgroundColor = color(0,0,0,0);
    conway.foregroundColor = colors[i];
    conway.colorStyle = ColorStyle.Solid;
    conways[i] = conway;
  }
  
}

void draw() 
{
  background(0);
  for (int i=0;i<conways.length;i++) {
    Conway c = conways[i];
    c.draw();
    int offset = i * 5;
    image(c.pg, offset, offset);
  }
}