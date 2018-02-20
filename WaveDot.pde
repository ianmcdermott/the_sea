class WaveDot {
  float x, y, rMax, rStart;
  int hue, sat, bright;
  float r = 0;
  float initialRadius;
  boolean isDead = false;


  WaveDot(float _x, float _y, float _r, int h, int s, int b) {
    x = _x;
    y = _y;
    rMax = _r;
    hue = h;
    sat = s;
    bright = b;
    waveDotCount++;
  }

  void update(float l, float ls, float index) {

    float i = index;
    if (i > rMax) i = rMax;
    r++;
    if (r >= rMax) r = rMax;

    r-= rMax-i;
    if (r < 0) {
      r = 0;
      //isDead = true;
    }
  }

  void display() {
    //scale(r/5);
    //tint(hue, sat, bright, .1);
    //image(bubbleImage, 0, 0);
    fill(hue, sat, bright);
    //ellipse(x-30, y-30, r/2, r/2);
    //ellipse(x-30, y+30, r/2, r/2);
    ellipse(x, y, r, r);
    //ellipse(x+30, y-30, r/2, r/2);
    //ellipse(x+30, y+30, r/2, r/2);
  }
}