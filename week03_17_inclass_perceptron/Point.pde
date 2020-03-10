// a single layer perceptron

//by Aven Le ZHOU (https://www.aven.cc)
// artMahcines & NYU Shanghai
// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020

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
