// a single layer perceptron

//by Aven Le ZHOU (https://www.aven.cc)
// artMahcines & NYU Shanghai
// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020

class Perceptron {
  float [] weights;
  int output;


  Perceptron(int input_size) {

    weights = new float[input_size];
    //weights[0] = random(-1, 1);
    //weights[1] = random(-1, 1);
    for (int i = 0; i < weights.length; i++) {
      weights[i] = random(-1, 1);
    }
  }


  int predict(float [] inputs) {
    //sum up and pass to the activation function
    float sum = 0;
    // x*w1 + y*w2
    // inputs[0]*w1 + inputs[0]*w2
    // sum = 0 + inputs[0]*weights[0] + inputs[1]*weights[1]

    for (int i = 0; i < inputs.length; i++) {
      sum += inputs[i]*weights[i];
    }

    int output_perceptron = activation(sum);
    return output_perceptron;
  }
  
  void train(float[] inputs, int true_val, float lr){
    
    int fake_val = predict(inputs);
    int error = true_val - fake_val;
    
    for(int i = 0; i < weights.length; i ++){
      weights[i] += error*lr*inputs[i];
    }
    
  }
}

int activation(float input) {
  int output;
  if (input < 0) output = 0;
  else output = 1;
  return output;
}
