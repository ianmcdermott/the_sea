class Wave {
  PVector loc, vel, acc;
  float r; 
  color c;
  float amp = 50;
  float freq = .5;
  float xO;
  float sineStart;
  float rStart;
  PImage bubbleImage;
  float rad;
  int hue, sat, bright;
  float lifespan;

  Wave(float x, float y, float radius, int h, int s, int b, float xOff, float xVel, float ss, PImage bI, float l) {
    loc = new PVector(x, y);
    vel = new PVector(xVel, 0);
    r = radius;
    rStart = radius;
    bubbleImage = bI;

    xO = xOff;
    sineStart = ss;
    rad =  random(TWO_PI);
    hue = h;
    sat = s;
    bright = b;
    lifespan = l;
  }

  void update(float yOff, float xOff) {
    loc.add(xOff, yOff); 
    loc.add(vel);
    //loc.mult(yOff);
    if(lifespan > 127) {
      r = map(lifespan, 255, 127, 0, rStart);
    } else {
      r = map(lifespan, 127, 0, rStart, 0);

    }
    if(r < 0) r = 0;

    if (loc.x > abs(r*2)+width) {
      loc.x = -abs(r*2);
    }
    lifespan-= 5;
    if(lifespan < lifeMin) lifespan = 255;
  }

  void display() {
    imageMode(CENTER);
    int mapAlpha = int(map(loc.y, height/3, height, 255, 20));  
    int mapBrightness = int(map(loc.y, height, height/1.5 , 0, bright));  

    noStroke();
    pushMatrix();
    float scalar = map(r, 0, rStart, 0, 2);

    translate(loc.x, loc.y);
    scale(scalar);
    fill(0);
    tint(0);

    image(bubbleImage, 0, 0);
    //  ellipse(0, 0, r-.1, r-.1);
    //fill(c, mapAlpha);
    tint(hue, sat, mapBrightness);
    rotate(rad);
    image(bubbleImage, 0, 0);
    //ellipse(0, 0, r, r);
    popMatrix();
  }
  
  void addDot(){
    
  }
}