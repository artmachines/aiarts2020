// convolution operation tutorial

// by Aven Le ZHOU (https://www.aven.cc)
// artMahcines & NYU Shanghai
// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020

// videos: 
// aiarts S20 week06 [pre-recoded] Convolution Explained: https://nyu.zoom.us/rec/share/vOgoJpvV9ltJAZ2cz2CAUKsKT62ieaa82yUY-aBcnUtWpaDUcF5WMLdVe8dMz5vm?startTime=1584769777000
// aiarts S20 week06 [pre-recorded] kernal: https://nyu.zoom.us/rec/share/u_YscOzB7EpOQYHM51ngSoh_II3oeaa8hCcc-_BYzk7Qg18bacLh859WAWquiRJD?startTime=1584770985000
// aiarts S20 week06 [pre-recorded] convolution: https://nyu.zoom.us/rec/share/tJ11BIjWxnxOTIHC-WHASK8bMLrqT6a81XIW-vANzR6zaGDPy1km3zR3W5E-1M2r?startTime=1584772793000


// an operation go through every pixel in the original image
// when with single pixel - center pixel, 
// we need to multiply a 3by3 kernel with the 3by3 grid around the center pixel

float[][] kernal = {
  { 1, 2, 1 }, 
  { 0, 0, 0 }, 
  { -1, -2, -1}
};

PImage img;

void setup() {

  size(1200, 600);
  imageMode(CENTER);
  img = loadImage("brick.jpg");
}

void draw() {
  noLoop();
  image(img, width/4, height/2);
  PImage conv_image = convolution(img, kernal);
  image(conv_image, 3*width/4, height/2);
}

PImage convolution(PImage img, float[][] kernal) {
  int w = img.width;
  int h = img.height;

  PImage conv_img = createImage(w, h, RGB);
  int conv_index =0;
  conv_img.loadPixels();
  for (int y = 0; y < h; y ++) {
    for (int x = 0; x < w; x ++) {
      conv_img.pixels[conv_index] = calculate_pixel(x, y, kernal, img);
      conv_index ++;
    }
    conv_img.updatePixels();
  }
  return conv_img;
}


color calculate_pixel(int conv_pos_x, int conv_pos_y, float[][] kernal, PImage img) {
  int kernal_h = kernal.length;
  int kernal_w = kernal[0].length;

  int offset_h = (kernal_h -1)/2;
  int offset_w = (kernal_w -1)/2;

  float sum_r = 0.0;
  float sum_g = 0.0;
  float sum_b = 0.0;
  for (int j = -offset_h; j <= offset_h; j++) { //y
    for (int i = -offset_w; i <= offset_w; i++) { //x
      int pos_x = conv_pos_x + i;
      int pos_y = conv_pos_y + j;
      color n_pixel = color(0);
      if (pos_x >=0 && pos_x < img.width&&pos_y>=0&&pos_y < img.height) {
        img.loadPixels();
        int index = pos_x + pos_y*img.width;
        n_pixel = img.pixels[index]; //color/pixel on the (pos_x, pos_y) poistion
        img.updatePixels();
      }

      //red()
      //blue()
      //green()

      /*
       float r1 = red(c);  // Simpler, but slower to calculate
       float r2 = c >> 16 & 0xFF;  // Very fast to calculate 
       float g1 = green(c);  // Simpler, but slower to calculate
       float g2 = c >> 8 & 0xFF;  // Very fast to calculate
       float b1 = blue(c);   // Simpler, but slower to calculate
       float b2 = c & 0xFF;  // Very fast to calculate
       */

      float nr = n_pixel >> 16 & 0xFF;  // Very fast to calculate 
      float ng = n_pixel >> 8 & 0xFF;  // Very fast to calculate
      float nb = n_pixel & 0xFF;  // Very fast to calculate


      sum_r += nr*kernal[j+offset_h][i+offset_w];
      sum_g += ng*kernal[j+offset_h][i+offset_w];
      sum_b += nb*kernal[j+offset_h][i+offset_w];
    }
  }
  sum_r = constrain(sum_r, 0, 255);
  sum_g = constrain(sum_g, 0, 255);
  sum_b = constrain(sum_b, 0, 255);
  return color(sum_r, sum_g, sum_b);
}
