color colorA = color(0x00, 0x63, 0xFF, 0xFA);
color colorB = color(0x46, 0xEC, 0xC8, 0xFA);
color colorC = color(0xFE, 0xFE, 0xFE, 0xFA);
color colorD = color(0x00, 0x3A, 0x94, 0xFF);
Conway conways[];

PImage mask;

void setup() 
{
  size(960, 600, P2D);
  frameRate(15);

  mask = loadImage("LateralLogo.png");

  color[] colors = {  colorA, colorB, colorC };
  
  int c = colors.length;
  conways = new Conway[c];
  for (int i=0;i<c;i++) {
    Conway conway = new Conway(47,30);
    conway.cellStyle = CellStyle.Hexagon;
    conway.mutationLevel = 7;
    conway.backgroundColor = color(0,0,0,0);
    conway.foregroundColor = colors[i];
    conway.colorStyle = ColorStyle.Solid;
    conways[i] = conway;
  }
}


void draw() 
{
  PGraphics buffer = createGraphics(width, height);
  buffer.beginDraw();
  buffer.fill(colorD);
  buffer.rect(0, 0, width, height);
  
  for (int i=0;i<conways.length;i++) {
    Conway c = conways[i];
    c.draw();
    int offset = i * 5;
    int w = c.pg.width;
    int h = c.pg.height;
    buffer.blend(c.pg, 0, 0, w, h, offset, offset, w, h, BLEND);
  }
  buffer.mask(mask);
  buffer.endDraw();
  image(buffer, 0, 0);
  
}