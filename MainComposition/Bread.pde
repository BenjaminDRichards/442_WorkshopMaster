class Bread {
  private PImage img;
  private PShader shdr;

  public boolean doAnimate = true; 
  float time = random(TWO_PI);
  float spd = random(2,4);

  Bread(String imgName) {

    img = loadImage(imgName);
    shdr = loadShader("breadShader.frag");
    shdr.set("tex", img);
    shdr.set("speed", spd);
    shdr.set("time", time);
  }

  public void draw(float x, float y, float i_w, float i_h) {
    //noStroke();
    fill(255);
    shader(shdr);
    shdr.set("time", time);
//    beginShape();
//    textureMode(NORMAL);
//    vertex(x-i_w/2, y-i_h/2, 0, 0);
//    vertex(x+i_w/2, y-i_h/2, 1, 0);
//    vertex(x+i_w/2, y+i_h/2, 1, 1);
//    vertex(x-i_w/2, y+i_h/2, 0, 1);
//    endShape();
    image(img, x-i_w/2, y-i_h/2, i_w, i_h);
    resetShader();
    
    time += 0.1;
  }
}

