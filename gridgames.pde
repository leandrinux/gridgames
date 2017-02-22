Conway conways[];

void setup() 
{
  size(960, 600, P2D);
  //pixelDensity(2);
  smooth(10);
  frameRate(15);

  color[] colors = { 
    color(0x00,0x63,0xFF,0xFA), 
    color(0x46,0xEC,0xC8,0xFA), 
    color(0xFE,0xFE,0xFE,0xFA) 
  };
  
  int c = colors.length;
  conways = new Conway[c];
  for (int i=0;i<c;i++) {

    Conway conway = new Conway(95,60);
    conway.cellStyle = CellStyle.Circle;
    conway.mutationLevel = 4;

    /*
    color colors[] = new color[4];
    colors[0] = color(0xff,0,0,0xBA);
    colors[1] = color(0,0xff,0,0xBA);
    colors[2] = color(0,0,0xff,0xBA);
    colors[3] = color(0xff,0xff,0xff,0xBA);
    conway.cornerColors = colors;
    conway.colorStyle = ColorStyle.Gradient;
    */
    
    conway.backgroundColor = color(0,0,0,0);
    conway.foregroundColor = colors[i];
    conway.colorStyle = ColorStyle.Solid;

    conways[i] = conway;
  }
  
}

void draw() 
{
  clear();
  for (Conway c : conways) {
    c.draw();
    image(c.pg, 0, 0);
  }
}