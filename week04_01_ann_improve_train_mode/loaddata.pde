// this uses the MNIST database of handwritten digits
// http://yann.lecun.com/exdb/mnist/ (accessed 04.06.09)

// note: Alasdair Turner has reduced the originals to 14 x 14 from 28 x 28

Datum [] training_set;
Datum [] testing_set;

class Datum {
  float [] inputs; // formatted to (-1,1) pixels values
  float [] outputs; // formatted to 10 digits, 1 or -1, stand for correct or wrong in terms of matching the original label
  PImage input_img = createImage(14, 14, RGB);
  int output;
  Datum() {
    inputs = new float [196];
    outputs = new float[10];
  }
  void imageLoad(byte [] images, int offset) {

    //images: a 1-D array with 196 elements, range from 0 to 255, byte type
    //convert to int
    int [] images_int = new int[images.length];
    for (int i = 0; i < 196; i++) {
      images_int[i] = int(images[i+offset]);
      //map to float (-1,1) from int (0,255)
      inputs[i] = images_int[i] / 128.0 - 1.0;
    }

    int [] image_size = {14, 14};
    input_img = array2image(images_int, image_size);
  }
  void labelLoad(byte [] labels, int offset) {
    output = int(labels[offset]);//label as integer 0~9
    for (int i = 0; i < 10; i++) {
      if (i == output) {
        outputs[i] = 1.0;
      } else {
        outputs[i] = -1.0;
      }
    }
  }
}

void loadData() {
  byte [] images = loadBytes("t10k-images-14x14.idx3-ubyte");
  byte [] labels = loadBytes("t10k-labels.idx1-ubyte");

  println(images.length);
  println(labels.length);

  training_set = new Datum [8000];
  int tr_pos = 0;
  testing_set = new Datum [2000];
  int te_pos = 0;

  for (int i = 0; i < 10000; i++) {
    if (i % 5 != 0) {
      training_set[tr_pos] = new Datum();
      training_set[tr_pos].imageLoad(images, 16 + i * 196);
      training_set[tr_pos].labelLoad(labels, 8 + i);
      tr_pos++;
    } else {
      testing_set[te_pos] = new Datum();
      testing_set[te_pos].imageLoad(images, 16 + i * 196);
      testing_set[te_pos].labelLoad(labels, 8 + i);
      te_pos++;
    }
  }
}
