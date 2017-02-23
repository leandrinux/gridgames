
color[] redTheme = { color(0xec450f, 0xFF), color(0xb9cc0f, 0xFF), color(0xa7fe0f, 0xFF), color(0xd3890f, 0xFF) };
color[] purpleTheme = { color(0xa836b0, 0xFF), color(0xaf369a, 0xFF), color(0xcd3641, 0xFF), color(0x9d37d2, 0xFF) };
color[] currentTheme;
color baseColor;
int updateColorEvery = 5;

PGraphics backgroundImage;
Conway conways[] = null;

void setup() 
{
  size(960, 600, P2D);
  frameRate(15);
    
  // set up color theme
  colorMode(HSB, 100);
  baseColor = color(0, 50, 100);
  updateTheme();
  
  // prepare conways
  float scale = 1.4;
  int c = currentTheme.length - 1;
  conways = new Conway[c];
  for (int i=0;i<c;i++) {
    Conway conway = new Conway(int(47*scale),int(30*scale));
    conway.cellStyle = CellStyle.Rectangle;
    conway.mutationLevel = 7;
    conway.backgroundColor = color(0,0,0,0);
    conway.foregroundColor = currentTheme[i];
    conway.colorStyle = ColorStyle.Solid;
    conways[i] = conway;
  }
 
  // prepare background noise
  backgroundImage = createGraphics(width, height);
  backgroundImage.beginDraw();
  int blockCount = 120;
  int blockSize = backgroundImage.width / blockCount;
  for (int x=0;x<blockCount;x++) {
    for (int y=0;y<blockCount;y++) {
      float n = noise(x,y)*0xFF;
      //set(x, y, color(n));
      backgroundImage.fill(n);
      backgroundImage.noStroke();
      backgroundImage.rect(x*blockSize, y*blockSize, blockSize, blockSize);
    }
  }
  backgroundImage.endDraw();
  
}

void updateTheme() {
    
  color[] theme = new color[4];
  colorMode(HSB, 100);
  theme[0] = color(hue(baseColor)*0.85, 100, 50);
  theme[1] = baseColor;
  theme[2] = color(hue(baseColor)*1.15, 100, 50);
  theme[3] = color(hue(baseColor)*1.25, 100, 50);  
  currentTheme = theme;
  
  if (conways != null) {
    for (int i=0;i<conways.length;i++) {
      conways[i].foregroundColor = currentTheme[i];
    }
  }
  
}

void updateBaseColor() {
  colorMode(HSB, 100);
  float h = hue(baseColor);
  if (h >= 100) 
    baseColor = color(0, 100, 50);
  else
    baseColor = color(h+1, 100, 50);
  updateTheme();
}

void draw() 
{
  
  PGraphics buffer = createGraphics(width, height);
  buffer.beginDraw();
  
  // update colors if needed
  if (conways[0].cycleCount % updateColorEvery == 0) {
    updateBaseColor();       
  }
  
  // prepare the background
  buffer.clear();
  buffer.fill(currentTheme[currentTheme.length-1]);
  buffer.rect(0, 0, width, height);
  buffer.blend(backgroundImage, 0, 0, width, height, 0, 0, width, height, SUBTRACT);
 
  // draw the conways
  for (int i=0;i<conways.length;i++) {
    Conway c = conways[i];
    c.draw();
    int offset = i * 5;
    int w = c.pg.width;
    int h = c.pg.height;
    buffer.blend(c.pg, 0, 0, w, h, offset, offset, w, h, ADD);
  }
  
  // buffer.mask(mask);
  buffer.endDraw();
  
  // finally display the frame on screen
  image(buffer, 0, 0);
 
}