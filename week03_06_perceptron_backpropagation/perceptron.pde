// a single layer perceptron

//by Aven Le ZHOU (https://www.aven.cc)
// artMahcines & NYU Shanghai
// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020


class Perceptron {
  float[] weights;

  int output;
  
  float lr;

  Perceptron(int input_size, float _lr) {
    weights = new float [input_size];
    for (int i = 0; i < weights.length; i++) {
      weights[i] = random(-1, 1);
    }
    
    lr = _lr;
  }

  int predict(float [] inputs) {
    // sum and activation function
    float sum = 0;
    for (int i = 0; i < inputs.length; i++) {
      sum += inputs[i]*weights[i];
    }

    int output = sign(sum);

    return output;
  }

  void train(float[] inputs, int true_val) {

    int fake_val = predict(inputs);
    int error = true_val - fake_val;

    for (int i = 0; i < weights.length; i ++) {
      weights[i] += error*inputs[i]*lr;
    }
  }
}
