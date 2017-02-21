Conway conway;

void setup() 
{
  size(960, 600, P2D);
  pixelDensity(2);
  frameRate(30);
  
  conway = new Conway(50,40);
}

void draw() 
{
  conway.draw();
}