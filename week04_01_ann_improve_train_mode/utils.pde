// function to convert 1D array to processing PImage
// note: 
// 1. image_size should be {w, h} array that match the image array length
// 2. the output will be a RGB image present the grayscale image,
//    since I didnt find a grayscale image option in PImage

PImage array2image(int [] image_array, int [] image_size) {
  int w = image_size[0];
  int h = image_size[1];
  PImage image = createImage(w, h, RGB);
  image.loadPixels();
  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      int pixel_index = y*w + x;
      image.pixels[pixel_index] = color(image_array[pixel_index]);
    }
  }
  image.updatePixels();
  return image;
}


// softmax function

float [] softmax(float [] inputs) {
  
  int len = inputs.length;
  float [] outputs = new float[len];
  float [] exp = new float[len];
  float exp_sum = 0;
  
  for (int i = 0; i < len; i++) {
    exp[i] = exp(inputs[i]);
    exp_sum += exp[i];
  }
  
  for (int i = 0; i < len; i++) outputs[i] = exp[i] / exp_sum;
  
  return outputs;
}


// sigmoid
float sigmoid(float x) {
  x = 2* (constrain(((x + 5)*20), 0, 199)/20.0 - 5.0);
  return 2.0/(1.0 + exp(-x)) - 1.0;
}



/* 
 major updates:
 
 1. add softmax function, so the network can output probabiliies
 2. replace the sigmoid (look up table) function to actual sigmoid function - calculate each time
 3. add train function to mimic the actual training mechanism, such as batch_size, epoch, and learning rate adjustment 
 add evaluation function to calculate loss
 
 2. add three visulization function to visualize:
     a. the raw data of input and output 
     b. the raw data as pixels matrix and PImage
     c. the weights of each layer
         I.  as as pixels matrix
         II. and PImage
 3. layout design
 4. seprate training and inference mode
 */
