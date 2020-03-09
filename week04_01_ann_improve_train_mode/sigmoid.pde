// Simple neural nets: sigmoid functions
// (c) Alasdair Turner 2009

// Free software: you can redistribute this program and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// a sigmoid function is the neuron's response to inputs
// the sigmoidal response ranges from -1.0 to 1.0

// for example, the weighted sum of inputs might be "2.1"
// our response would be lookupSigmoid(2.1) = 0.970

// this is a look up table for sigmoid (neural response) values
// which is valid from -5.0 to 5.0


//float [] g_sigmoid = new float [200];

//// this function precalculate a sigmoid (response) function
//void setupSigmoid() {
//  for (int i = 0; i < g_sigmoid.length; i++) {
//    float x = (i / 20.0) - 5.0;
//    g_sigmoid[i] = 2.0 / (1.0 + exp(-2.0 * x)) - 1.0;
//  }
//}

// once the sigmoid has been set up, this function accesses it:
//float lookupSigmoid(float x){
//  return g_sigmoid[constrain((int) floor((x + 5.0) * 20.0),0,199)];
//}
