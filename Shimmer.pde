class Shimmer {
  float rMax, x, y, r;
  float life = 100;
  boolean isDead = false;
  Shimmer(float _x, float _y, float _rMax) {
    x = _x;
    y = _y;
    rMax = _rMax;
  }

  void display() {
    fill(360);
    ellipse(x, y, r, r);
  }

  void update() {
    if (life > 50) {
      r++;
      if (r >= rMax) r = rMax;
    } else {
      r--;
      if(r <= 0) r = 0;
    }
    life--;
  }

  boolean isDead() {
    if (life <= 0) {
      return true;
    } else { 
      return false;
    }
  }
}