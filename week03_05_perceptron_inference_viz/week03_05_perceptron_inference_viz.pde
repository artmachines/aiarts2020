// a single layer perceptron

//by Aven Le ZHOU (https://www.aven.cc)
// artMahcines & NYU Shanghai
// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020

Point [] pts;

Perceptron neural_network = new Perceptron(2);

void setup() {
  size(800, 800);
  background(200);
  rectMode(CENTER);
  
  pts = new Point[1000];

  for (int i =0; i < pts.length; i ++) {
    pts [i] = new Point();
  }
}

void draw() {
  noLoop();

  //dots, with position (x, y) as input, and color (0, 1) as output

  for (Point pt : pts) {
    pt.display();
  }

  //predict

  for (Point pt : pts) {
    //pt.x , pt.y
    float[] input_pt_pos = {pt.x, pt.y};
    //predict
    int prediction = neural_network.predict(input_pt_pos);

    if (prediction == pt.val) {
      //correct
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    ellipse(pt.x, pt.y, 8, 8);
  }
}
