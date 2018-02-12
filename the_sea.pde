Wave[] w = new Wave[1000];
float amp = 2.5;
float freq = .25;
float yNoise;
PImage[] bubble = new PImage[1];
PGraphics pg; 
float lifeMin = -10000;
void setup() {
  //frameRate(200);
  fullScreen(P2D);
  //size(800, 800);
  background(0);
  pg = createGraphics(width, height);
  bubble[0] = loadImage("bubble-small.png");
  //bubble[1] = loadImage("bubble-small2.png");
  //bubble[2] = loadImage("bubble-small3.png");
  //colorMode(RGB);
  fill(0, 100, 245, 10);
  for (int i = 0; i < height; i++) {
    float s = map(i, height/2, height, 255, 0);
    stroke(s/10, s/2.5, s);
    line(0, i, width, i);
  }
  for (int i = 0; i < w.length; i++) {
    w[i] = new Wave(random(width), random(height/1.99, height), random(20, 40), 
      int(random(190, 220)), int(random(100, 255)), int(random(200, 255)), 
      random(100), random(5), random(200), bubble[int(random(bubble.length))], random(lifeMin, 255));
  }
  colorMode(HSB, 360, 100, 100);
}

void draw() {
  //yNoise = sin(frameCount*.05)*100;
  //rect(0, 0, width, height);
    //translate(0, yNoise);

  pushMatrix();
  for (int i = 0; i < w.length; i++) {
    float yOff = cos(((frameCount+i))*freq)*amp;
    float xOff = noise(frameCount+i*10);
    w[i].update(yOff, xOff); 
    w[i].display();
  }
  println(w[0].r);
  popMatrix();
}