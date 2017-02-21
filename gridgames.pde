Conway conway;

void setup() 
{
  size(1280, 800, P2D);
  pixelDensity(2);
  frameRate(15);
  conway = new Conway(80,50);
  conway.spacing = 0;
}

void draw() 
{
  conway.draw();
}