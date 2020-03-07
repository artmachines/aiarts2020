// a single layer perceptron

//by Aven Le ZHOU (https://www.aven.cc)
// artMahcines & NYU Shanghai
// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020

Point [] pts; //declare the array
//Point [] pts = new Point[1000];

Perceptron neural_network;
float learning_rate = 0.0001;
void setup() {
  size(800, 800);
  background(200);
  pts = new Point[1000];

  for (int i = 0; i < pts.length; i ++) {
    pts[i] = new Point();
  }

  neural_network = new Perceptron(2);
  rectMode(CENTER);
  noStroke();
}

void draw() {
  //for (int i = 0; i < pts.length; i ++) {
  //  pts[i].display();
  //}

  //viz/display the data
  for (Point pt : pts) {
    pt.display();
  }


  //inference, predict, using the model
  for (Point pt : pts) {
    //inputs: pt.x , pt.y
    float [] inputs = {pt.x, pt.y};

    int prediction = neural_network.predict(inputs);
    //println(prediction);

    if (prediction == pt.val) fill(0, 255, 255);
    else fill(255, 0, 255);
    ellipse(pt.x, pt.y, 10, 10);
  }
}


void keyPressed() {
  //train
  int batch_size = 50;
  for (int i = 0; i < batch_size; i ++) {
    //randomly pick one dot from the dataset
    int random_index = (int)random(pts.length);
    Point pt_sample = pts[random_index];
    float [] inputs = {pt_sample.x, pt_sample.y};
    int true_val = pt_sample.val;
    /* data pair: 
     inputs: (x,y)
     true_val: 0 or 1
     */
    neural_network.train(inputs, true_val, learning_rate);
  }
}
