// matrix
// multiply operation

// by Aven Le ZHOU (https://www.aven.cc)
// artMahcines & NYU Shanghai
// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020

// matrix: https://en.wikipedia.org/wiki/Matrix_(mathematics)
// processing two D array: https://processing.org/tutorials/2darray/
// matrix multiplication: https://en.wikipedia.org/wiki/Matrix_multiplication


//video tutorial: https://nyu.zoom.us/rec/share/ydJXdrKt2EdISZ3Cwx-CXYoEENrFeaa81yke8_EKyU1qUFo7oZsxlkIm0iLaGDMK?startTime=1584328543000

int[][] matrix_m_n = { // 2 by 3 matrix, m * n
  // m * n
  // m = 2
  // n =3
  {3, 2, -1}, 
  {0, 4, 6}
};

int[][] matrix_n_k = { // 3 by 2 matrix, n * k
  //n * k
  // n =3, k = 2
  {1, 0}, 
  {5, 3}, 
  {6, 4}
};

void setup() {

  int m = matrix_m_n.length;
  int k = matrix_n_k[0].length;
  int n = matrix_n_k.length;
  int [][] matrix_m_k = new int[m][k];
  for (int j = 0; j < m; j++) {
    for (int i = 0; i < k; i++) {
      for (int _n = 0; _n < n; _n++) {
        matrix_m_k[j][i] += matrix_m_n[j][_n] * matrix_n_k[_n][i];
      }
    }
  }
  for (int i = 0; i < matrix_m_k.length; i++)printArray(matrix_m_k[i]);
}

void draw() {
}
