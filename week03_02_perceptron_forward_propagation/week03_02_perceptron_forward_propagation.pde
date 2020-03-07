// a single layer perceptron

//by Aven Le ZHOU (https://www.aven.cc)
// artMahcines & NYU Shanghai
// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020

Point [] pts;

void setup() {
  size(800, 800);
  background(200);
  pts = new Point[100];

  for (int i =0; i < pts.length; i ++) {
    pts [i] = new Point();
  }
}

void draw() {
  //dots, with position (x, y) as input, and color (0, 1) as output

  for (Point pt : pts) {
    pt.display();
  }
}
