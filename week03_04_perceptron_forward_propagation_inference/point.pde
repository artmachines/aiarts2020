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
    //apply certain logic to color based on pos

    if (x > y) {
      val = 1;
    } else {
      val = 0;
    }
  }

  void display() {
    int clr = (int)map(val, -1, 1, 0, 255);
    fill(clr);
    rect(x, y, 10, 10);
  }
}
