class Point {
  float x, y;
  int val;

  Point() {
    x = random(width);
    y = random(height);

    if (x > y) val = 0;
    else val = 1;

    //if (x > y) {
    //  val = 0;
    //} else { 
    //  val = 1;
    //}
  }

  void display() {
    int clr = (int)map(val, 0, 1, 0, 255);
    //int clr = int(map(val, 0, 1, 0, 255));
    fill(clr);
    rect(x, y, 10, 10);
  }
}
