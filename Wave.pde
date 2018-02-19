class Wave {
  PVector loc, vel, acc;
  float r; 
  color c;
  float amp;
  float freq;
  float xO;
  float sineStart;
  float rStart;
  PImage bubbleImage;
  float rad;
  int hue, sat, bright;
  float life;
  JSONArray ellipseArray;
  float lifespan;
  float waveLife = 400;
  float alpha = 255;
  float frameStart;
  float radio = 0;
  ArrayList <WaveDot> waveDots;
  //WaveDot[] waveDots;
  float xStart;
  float yStart;
  float x ;
  float y; 

  Wave(float _x, float _y, float a, float f, float _rad, int h, int s, float xOff, float xVel, float ss, PImage bI, float l, int fs, int b) {
    rStart = _rad;
    bubbleImage = bI;

    xO = xOff;
    sineStart = ss;
    rad =  _rad;
    hue = h;
    sat = s;
    bright = b;
    life = l;
    lifespan = l;
    freq = f;
    amp = a;
    ellipseArray = new JSONArray();
    frameStart = fs;
    waveDots = new ArrayList <WaveDot>();
     xStart = _x;
     yStart = _y;
    waveDots.add(new WaveDot(xStart, yStart, 0, hue, sat, bright));
  }

  void update(float yOff) {

    if (waveDots.size() >= 1) {
      WaveDot firstWaveDot = waveDots.get(0);

      //if there is still "life(change to growth)" remaining add a new node
      if (life > 0) {
        if (life > 2) {
          r = map(life, lifespan, lifespan/2, 0, rStart);//*noise(frameCount/100)*10;
        } else {
          r = map(life, lifespan/2, 0, rStart, 0);
        }
        x = xStart-frameStart*xO+(frameCount)*xO;
        y = yOff;
        waveDots.add(new WaveDot(x, y, r, hue, sat, bright));
        life-= 2;
      }
      waveLife -= 1;
    }
  }


  //Delete node until life is no more, once life no more, isDead == true
  void deleteNode() {
    if (waveLife <= 255 && !isDead()) {
      if (waveDots.size() >= 1) {
        waveDots.remove(0);
        alpha = waveLife;
      }
    }
  }

  boolean isDead() {
    if (waveLife <= 0) {
      return true;
    } else { 
      return false;
    }
  }

  void display() {
    imageMode(CENTER);
    noStroke();
    for (int i =0; i < waveDots.size(); i++) {
      WaveDot wd = waveDots.get(i);
      waveDots.get(i).update(life, lifespan, i);
      if (wd.x > -200 && wd.x < width+200 && wd.y < height+200) {
        pushMatrix();
        //translate(w.x, w.y);
        wd.display();
        //ellipse(0, 0, w.r,w.r);
        popMatrix();
      }
    }
  }
}