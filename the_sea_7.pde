float amp = 50;
float freq = .025;
float offset = .5;
float xOff = 100;
float yNoise;
PImage[] bubble = new PImage[1];

float lifeMin = 600;
float lifeMax = 1200;
float padding = 6;
int waveDotCount = 0;
float x = 0;
float y = 0;
PImage bubbleImage;
ArrayList<Shimmer> shimmer;
WaveHolder[] waveHolder = new WaveHolder[3];

PShape photo;
//import processing.pdf.*;
JSONObject drawing;
PGraphics pg; 


void setup() {
  //size(1800, 1200, P2D);
  //fullScreen(P2D);
  background(200);
  size(2560, 1440);
  drawing = loadJSONObject("data/art.json");
  photo = loadShape("data/filename.svg");
  bubble[0] = loadImage("bubble-small.png");
  bubbleImage = bubble[0];
  shimmer = new ArrayList<Shimmer>();
  for (int i = 0; i < waveHolder.length; i++) {
    waveHolder[i] = new WaveHolder(-width/4, height/padding*i-500, width+width/4, height/100, 200, 300, .005, .0075, 255-(waveHolder.length-i-1)*75);
  }
  //smooth();
  //populateWave();
  pg = createGraphics(1000, 1000);
  pg.beginDraw();
  displayDrawing(0, 0);
  pg.endDraw();
}

void draw() {
  colorMode(RGB);
  background(180, 220, 255);
  println(frameCount);
  //amp = map(mouseX, 0, width, 0, 100);
  //freq = map(mouseY, 0,height, 0, 1);
  for (int i = 0; i < height; i++) {
    float s = map(i, height/2, height, 255, 50);
    stroke(s/10, s/2.5, s);
    line(0, i, width, i);
  }

  for (int i = 0; i < waveHolder.length; i++) {

    x = sin(frameCount*freq+offset*i)*amp-width/2;
    if (i == 1) {
      pushMatrix();
      rectMode(CENTER);
      translate(width/2+x+xOff, y-600);
      rotate(radians((x-180)/4));
      shape(photo, 0, 0, 1000, 1000);
      //rect(0, 0, 500, 200);
      //image(pg, 0, 0);

      popMatrix();
    } else     if (i == 0) {
      pushMatrix();
      rectMode(CENTER);
      translate(width-xOff, y-900);
      rotate(radians((x-180)/4));
      //rect(0, 0, 500, 200);
      //image(pg, 0, 0);

      popMatrix();
    } else     if (i == 2) {
      pushMatrix();
      rectMode(CENTER);
      translate(width-xOff, y);
      rotate((radians((y)-80)/4));
      //image(pg, 0, 0);

      popMatrix();
    }
    y = cos(frameCount*freq+offset*i)*amp+height-200;

    if ((frameCount % 10) == 0) {
      for (int j = 0; j < 20; j++) {
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

  //for (Shimmer s : shimmer) {
  //  s.update();
  //  s.display();
  //}

  //shimmer.add(new Shimmer(random(width), random(height/2, height), random(20)));
  xOff+=3;
  println(waveDotCount);
    //saveFrame("frames/frame-######.png"); 
}
void  populateWave() {
  for (int i = 0; i < waveHolder.length; i++) {

    for (int j = 0; j < 100; j++) {
      waveHolder[i].addWave(400, 800);
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

void displayDrawing(float _x, float _y) {
  pushMatrix();
  translate(_x, _y);
  JSONArray frames = drawing.getJSONArray("frame");
  if (drawing != null) {
    for (int i = 0; i < frames.size(); i++) {
      JSONObject frame = frames.getJSONObject(i);
      JSONArray lines = frame.getJSONArray("lines");
      JSONArray points = frame.getJSONArray("points");

      float weight = frame.getFloat("radius");//responsiveRatio;

      if (lines != null) {

        for (int j = 0; j < lines.size(); j++) {
          //unhex the hex value, into a usable int, take away the hex # using substring
          int c = int(unhex("FF"+frame.getString("color")));
          pg.strokeWeight(weight);
          pg.stroke(c);
          pg.line(lines.getJSONObject(j).getFloat("mouseX"), lines.getJSONObject(j).getFloat("mouseY"), lines.getJSONObject(j).getFloat("pmouseX"), lines.getJSONObject(j).getFloat("pmouseY"));
        }
      }
      if (points != null) {
        for (int j = 0; j < points.size(); j++) {
          int c = int(unhex("FF"+frame.getString("color")));
          pg.noStroke();
          pg.fill(c);
          pg.ellipse(points.getJSONObject(j).getFloat("x"), points.getJSONObject(j).getFloat("y"), 50, 50);
        }
      }
    }
  }
  popMatrix();
}