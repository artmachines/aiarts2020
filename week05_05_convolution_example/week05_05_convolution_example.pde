// convolution with sobel operator, gaussian blur & .etc

// by Aven Le ZHOU (https://www.aven.cc)
// artMahcines & NYU Shanghai
// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020


PImage img;

float[][] kernal = { 

  //{ 1, 2, 1 }, 
  //{ 0, 0, 0 }, 
  //{ -1, -2, -1 }

  //{ 1, 0, -1 }, 
  //{ 2, 0, -2 }, 
  //{ 1, 0, -1 }

  {1, 0, -1}, 
  {0, 0, 0}, 
  {-1, 0, 1}

  //{ 0.0625, 0.125, 0.0625}, 
  //{ 0.125, 0.25, 0.125 }, 
  //{ 0.0625, 0.125, 0.0625}
}; 


int stride = 2;

void setup() {
  size(1200, 600);
  imageMode(CENTER);
  img = loadImage("brick.jpg");
}

void draw() {
  noLoop();
  image(img, width/4, height/2);
  PImage conv_image = convolution(img, kernal, stride);
  image(conv_image, 3*width/4, height/2);
}


PImage convolution(PImage img, float[][] kernal, int stride) {
  /*
  int w, h;
   if (img.width%stride == 0) {
   w = img.width/stride;
   h = img.height/stride;
   } else {
   w = img.width/stride+1;
   h = img.height/stride+1;
   }
   */

  int w = img.width/stride;
  int h = img.height/stride;

  if (img.width%stride != 0) {
    w ++;
    h ++;
  }

  PImage conv_img = createImage(w, h, RGB);
  conv_img.loadPixels();
  int conv_index = 0;

  for (int y = 0; y < img.height; y += stride ) {
    for (int x = 0; x < img.width; x += stride) {
      conv_img.pixels[conv_index] = caculate_kernal(x, y, kernal, img);
      conv_index ++;
    }
  }
  conv_img.updatePixels();

  return conv_img;
}


color caculate_kernal(int conv_pos_x, int conv_pos_y, float[][] kernal, PImage img) {
  int kernal_h = kernal.length;
  int kernal_w = kernal[0].length; 

  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;

  int offset_w = (kernal_w - 1) / 2;
  int offset_h = (kernal_h - 1) / 2;
  for (int j= -offset_h; j <= offset_h; j++) {
    for (int i = -offset_w; i <= offset_w; i++) {
      int adjacent_pixel_x = conv_pos_x+i;
      int adjacent_pixel_y = conv_pos_y+j;

      //zero padding
      color adjacent_pixel = color(0);
      if (adjacent_pixel_x >= 0 && adjacent_pixel_x < img.width &&
        adjacent_pixel_y >= 0 && adjacent_pixel_y < img.height) {
        int adjacent_pixel_index = adjacent_pixel_x + img.width*adjacent_pixel_y;
        img.loadPixels();
        //println(adjacent_pixel_index);
        adjacent_pixel = img.pixels[adjacent_pixel_index];
        img.updatePixels();
      }

      /*
       float r1 = red(c);  // Simpler, but slower to calculate
       float r2 = c >> 16 & 0xFF;  // Very fast to calculate 
       float g1 = green(c);  // Simpler, but slower to calculate
       float g2 = c >> 8 & 0xFF;  // Very fast to calculate
       float b1 = blue(c);   // Simpler, but slower to calculate
       float b2 = c & 0xFF;  // Very fast to calculate
       */

      float r = adjacent_pixel >> 16 & 0xFF;
      float g = adjacent_pixel >> 8 & 0xFF;
      float b = adjacent_pixel & 0xFF;

      // convolution sum
      rtotal += ( r * kernal[j+offset_h][i+offset_w]);
      gtotal += ( g * kernal[j+offset_h][i+offset_w]);
      btotal += ( b * kernal[j+offset_h][i+offset_w]);
    }
  }
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  return color(rtotal, gtotal, btotal);
}
