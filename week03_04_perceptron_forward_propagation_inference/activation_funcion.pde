// a single layer perceptron

//by Aven Le ZHOU (https://www.aven.cc)
// artMahcines & NYU Shanghai
// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020

//activation function, recieves input and caculate output

int sign(float x) {
  int output;

  if ( x > 0) {
    output = 1;
  } else {
    output = 0;
  }

  return output;
}
