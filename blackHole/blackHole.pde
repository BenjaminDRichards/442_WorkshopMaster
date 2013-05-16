//oliver ellmers is king. long live the king

import processing.video.*;

Movie theMov; 
PShader myShader;
PImage bg;

int startX, startY;

// If true, shows a textured background
// Else, the background is black 
// (left-click to switch)
Boolean isImageBackground = true;

void setup() {
  size(displayWidth, displayHeight, OPENGL);
  noSmooth();
  
  bg = loadImage("space_img02.jpg");
  theMov = new Movie(this, "squares_loop.mov");
  theMov.loop();
}

void draw() {
  
  image(theMov, 0, 0);
  
  if (isImageBackground == false)  { image(theMov, -1000, 0, width*2, height*2);tint(255, 126);}//blend(theMov, 0, 0, 33, 100, 67, 0, 33, 100, SUBTRACT); }//image(bg, 0, 0, width, height); }
  else                            { background(0); }
  int time = millis();
  myShader = loadShader("shader.frag");
  myShader.set("resolution", float(width), float(height));
  myShader.set("mouse", float(mouseX), float(mouseY));
  myShader.set("time", time);
  shader(myShader);
  
  noStroke();
  fill(0);
  rect(0, 0, width, height);
  resetShader();
}

final float effectAmount = 0.75;

void Spherize(int xPos, int yPos, int radius)
{
  int tlx = xPos - radius, tly = yPos - radius;
  PImage pi = get(tlx, tly, radius * 5, radius * 5);
  for (int x = - radius; x < radius; x++)
  {
    for (int y = - radius; y < radius; y++)
    {
  // Rescale cartesian coords between -1 and 1
  float cx = (float)x / radius;
  float cy = (float)y / radius;

  // Outside of the sphere -> skip
  float square = sq(cx) + sq(cy);
  if (square >= 1)
    continue;

  // Compute cz from cx & cy
  float cz = sqrt(1 - square);

  // Cartesian coords cx, cy, cz -> spherical coords sx, sy, still in -1, 1 range
  float sx = atan(effectAmount * cx / cz) * 2 / PI;
  float sy = atan(effectAmount * cy / cz) * 2 / PI;

  // Spherical coords sx & sy -> texture coords
  int tx = tlx + (int)((sx + 1) * radius);
  int ty = tly + (int)((sy + 1) * radius);

    // Set pixel value
  int alpha = (int)(255 * sq(1 - square)) << 24;
  pi.set(radius + x, radius + y, alpha | (0xFFFFFF & get(tx, ty)));
    }
  }
  set(tlx, tly, pi);
}

void mousePressed() {
  isImageBackground = !isImageBackground;
  startX = mouseX; startY = mouseY;
}

void mouseReleased()
{
  float radius = sqrt(sq(startX - mouseX) + sq(startY - mouseY));
  Spherize(startX, startY, int(radius));
}

void movieEvent(Movie m) { 
  m.read(); 
}
