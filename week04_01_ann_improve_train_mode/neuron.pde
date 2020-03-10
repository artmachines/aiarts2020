// Simple neural nets: neuron
// (c) Alasdair Turner 2009

// Free software: you can redistribute this program and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This class is for each neuron.  It works
// as a feed-forward multilayer perceptron, 
// learning by backpropagation

float LEARNING_RATE = 0.01;

class Neuron{
  Neuron [] m_inputs;
  float [] m_weights;
  float m_threshold;
  float m_output;
  float m_error;
  // the input layer of neurons have no inputs:
  Neuron(){
    m_threshold = 0.0;
    m_error = 0.0;
    // initial random output
    m_output = sigmoid(random(-5.0, 5.0));
  }
  // all other layers (hidden and output) have 
  // neural inputs
  Neuron(Neuron [] inputs){
    m_inputs = new Neuron [inputs.length];
    m_weights = new float [inputs.length];
    for (int i = 0; i < inputs.length; i++) {
      m_inputs[i] = inputs[i];
      m_weights[i] = random(-1.0, 1.0);
    }
    m_threshold = random(-1.0, 1.0);
    m_error = 0.0;
    // initial random output
    m_output = sigmoid(random(-5.0, 5.0));
  }
  // respond looks at the layer below, and prepares a response:
  float inference(){
    float input = 0.0;
    for (int i = 0; i < m_inputs.length; i++) {
      input += m_inputs[i].m_output * m_weights[i];
    }
    m_output = sigmoid(input + m_threshold);
    // reset our error value ready for training
    m_error = 0.0;
    return m_output;
  }
  // find error is used on the output neurons
  void loss(float ground_truth){
    m_error = ground_truth - m_output;
  }
  // train adjusts the weights by comparing actual output to correct output
  void train(float lr){
    float delta = (1.0 - m_output) * (1.0 + m_output) * m_error * LEARNING_RATE;
    for (int i = 0; i < m_inputs.length; i++) {
      // tell the next layer down what it's doing wrong
      m_inputs[i].m_error += lr*m_weights[i] * m_error;
      // correct our weights
      m_weights[i] += lr*m_inputs[i].m_output * delta;
    }
  }
  void display(boolean not_hidden){
    //float level = (0.5-m_output*0.5); 
    float level = 0.5*(1 - m_output); 
    if (not_hidden) {
      fill(255 * level);
    } else {
      // merge hidden layer with background color
      fill(110 + 128 * level, 102 + 128 * level, 127 + 128 * level);
    }
    rect(0, 0, 16, 16);
    //text(str(int(level)), 0, 0);
  }
}
