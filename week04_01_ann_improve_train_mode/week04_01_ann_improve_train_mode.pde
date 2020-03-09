
// adapted from (c) Alasdair Turner 2009 example: https://www.openprocessing.org/sketch/2292/

/* 
 major updates:
 
 1. add softmax function, so the network can output probabilities
 2. replace the sigmoid (look up table) function to actual sigmoid function - calculate each time
 3. add learning rate
 4. add train function to mimic the actual training mechanism, such as batch_size, epoch, and learning rate adjustment 
 add evaluation function to calculate loss
 
 to do: 
 I. add three visulization function to visualize:
 a. the raw data of input and output 
 b. the raw data as pixels matrix and PImage
 c. the weights of each layer
 I.  as as pixels matrix
 II. and PImage
 3. layout design
 4. seprate training and inference mode
 */

// by Aven Le ZHOU (https://www.aven.cc)
// artMahcines & NYU Shanghai
// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020


Network neuralnet;

PFont font;

PImage image_sample = createImage(14, 14, RGB);

void setup() {
  size(1000, 1000);

  font = loadFont("LucidaSans-20.vlw");
  rectMode(CENTER);
  textFont(font);
  textSize(15);
  textAlign(CENTER);
  noStroke();
  smooth();
  //setupSigmoid();
  loadData();
  neuralnet = new Network(196, 49, 10); // 24*24 --> 7*7 -->10 --> label

  background(0, 150, 150);
}

//boolean b_dataloaded = false;

// left click to test, right click (or ctrl+click on a Mac) to train
//boolean b_train = false, b_test = false;

void draw() {
  //background(0, 150, 150);

  //if (b_train || b_test) {
  //  background(0, 150, 150);
  //}
  //int response = -1, actual = -1;
  //if (!b_dataloaded) {
  //  loadData();
  //  b_dataloaded = true;
  //  b_test = true;
  //  printArray(training_set[0].outputs);
  //  print(training_set[0].output);
  //}

  //if (b_train) {
  //  // this allows some fast training without displaying:
  //  for (int i = 0; i < 500; i++) {
  //    // select a random training input and train
  //    int row = (int) floor(random(0, training_set.length));
  //    response = neuralnet.inference(training_set[row].inputs);
  //    actual = training_set[row].output;
  //    neuralnet.train(training_set[row].outputs);
  //    background(0, 150, 150);
  //    pushMatrix();
  //    neuralnet.display();
  //    popMatrix();
  //  }
  //} else if (b_test) {
  //  int row = (int) floor(random(0, testing_set.length));
  //  response = neuralnet.inference(testing_set[row].inputs);
  //  actual = testing_set[row].output;

  //  image(testing_set[row].input_img, 10, height-110, 100, 100);
  //}
  //if (b_train || b_test) {
  //  // draw
  //  //background(0, 150, 150);
  //  pushMatrix();
  //  neuralnet.display();
  //  popMatrix();
  //  b_train = b_test = false;
  //  fill(255, 0, 0);
  //  text("nn prediction: " + str(response), 65, 27);
  //  text("ground truth: " + str(actual), 65, height-127);
  //}
  //fill(105);
}

void mousePressed() {
  if (mouseButton == LEFT) {
    // random sample from the whole testing dataset
    int index = (int) floor(random(0, testing_set.length));
    Datum sample = testing_set[index];
    int true_label = sample.output;
    int fake_label = inference(sample);

    background(0, 150, 150);
    image(sample.input_img, 10, height-110, 100, 100);
    pushMatrix();
    neuralnet.display();
    popMatrix();

    fill(255, 0, 0);
    text("nn prediction: " + str(fake_label), 65, 27);
    text("ground truth: " + str(true_label), 65, height-127);
  } else {
    train(1000, 1000, 0.01);
  }
}


int inference(Datum sample) { 
  int fake_label = neuralnet.inference(sample.inputs);
  return fake_label;
}

void train(int batch_size, int epoch, float lr) {
  println("training in progress...");

  int dataset_size = training_set.length;
  int steps = int(dataset_size/batch_size);

  // this allows some fast training without displaying:
  for (int k = 0; k < epoch; k++) {
    for (int j = 0; j < steps; j++) {
      for (int i = 0; i < batch_size; i++) {
        // random sampling from the whole training dataset
        int index = (int) floor(random(0, training_set.length));
        neuralnet.train(training_set[index].outputs, lr);
      }
      println("step " + j + " of " + steps + " has been finished");
    }
    println("epoch " + k + " of " + epoch + " has been finished");
  }
  println("trainning has been finished");
  // train the nn with "batch_size" samples per time
  // and statically go through the whole training set when it reaches "steps" times
  // and go through the training set for "epoch" times
}
