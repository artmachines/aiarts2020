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
