float amp = 50;
float freq = .025;
float offset = .5;

float yNoise;
PImage[] bubble = new PImage[1];
PGraphics pg; 
float lifeMin = 600;
float lifeMax = 800;
float padding = 6;

float x = 0;
float y = 0;
PImage bubbleImage;
ArrayList<Shimmer> shimmer;
WaveHolder[] waveHolder = new WaveHolder[3];

void setup() {
  size(1800, 1200, P2D);
  background(200);
  bubble[0] = loadImage("bubble-small.png");
  bubbleImage = bubble[0];
  shimmer = new ArrayList<Shimmer>();
  for (int i = 0; i < waveHolder.length; i++) {
    waveHolder[i] = new WaveHolder(-width/4, height/padding*i-500, width+width/4, height/100, 200, 800, .005, .0075, 255-(waveHolder.length-i-1)*75);
  }
  smooth();
  //populateWave();
}

void draw() {
  colorMode(RGB);

  background(180, 220, 255);
  for (int i = 0; i < waveHolder.length; i++) {

    x = sin(frameCount*freq+offset*i)*amp-width/2;
    y = cos(frameCount*freq+offset*i)*amp+height;

    if ((frameCount % 8) == 0) {
      for(int j = 0; j < 2; j++){
      waveHolder[i].addWave(lifeMin, lifeMax);
    }
    }

    colorMode(HSB, 360, 255, 255);
    pushMatrix();
    translate(x+width/2, y);

    waveHolder[i].drawWave();
    waveHolder[i].update();
    popMatrix();
  }

  for (Shimmer s : shimmer) {
    //s.update();
    //s.display();
  }

  shimmer.add(new Shimmer(random(width), random(height/2, height), random(20)));
}
void  populateWave() {
  for (int i = 0; i < waveHolder.length; i++) {

    for (int j = 0; j < 100; j++) {
      waveHolder[i].addWave(600, 1200);
    }
  }
}

void deleteNode() {
  for (Shimmer s : shimmer) {
    if (s.isDead) {
      shimmer.remove(0);
    }
  }
}