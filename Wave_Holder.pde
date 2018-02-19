class WaveHolder {
  ArrayList <Wave> waveArray = new ArrayList<Wave>();
  float ampMin;
  float ampMax;
  float freqMin;
  float freqMax;
  float lifespan =1000;
  float x, y, w, h;
  int t;
  color c;

  WaveHolder(float _x, float _y, float _w, float _h, float aMin, float aMax, float fMin, float fMax, int _t) {
    ampMin = aMin;
    ampMax = aMax;
    freqMin = fMin;
    freqMax = fMax;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    t = _t;
    c= color(random(255), random(255), random(255));
    println(_t);
  }

  void addWave(float lMin, float lMax) {
    waveArray.add(new Wave(random(x, w), random(y, y+h*2), 
      random(ampMin, ampMax), random(freqMin, freqMax), 
      random(50, 80), int(random(210, 240)), int(random(100, 255)), 
      random(.5, 10), random(5), random(200), bubble[int(random(bubble.length))], random(lMin, lMax), frameCount, t));

    for (Wave w : waveArray) {
    }
  }

  void drawWave() {
    for (Wave w : waveArray) {
      w.update();
      w.deleteNode();
      w.display();
    }


    fill(c);
    ellipse(x, y, 25, 25);
  }

  void update() {
    lifespan -= 10;
    if (waveArray.size() > 0) {
      for (int i = waveArray.size()-1; i >= 0; i--) {
        Wave w = waveArray.get(i);
        if (w.isDead()) {
          waveArray.remove(i);
        }
      }
    }
  }
}