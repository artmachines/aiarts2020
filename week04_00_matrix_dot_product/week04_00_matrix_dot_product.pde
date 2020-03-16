// matrix
// multiply operation

// by Aven Le ZHOU (https://www.aven.cc)
// artMahcines & NYU Shanghai
// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020

//For example, the dimension of the matrix below is 2 × 3 (read "two by three"), 
// because there are two rows and three columns

int[][] matrixA = {
  {3, 2, -1}, 
  {0, 4, 6}
};
int[][] matrixB= {
  {1, 0}, 
  {5, 3}, 
  {6, 4}
};

void setup() {
  
  noLoop();
  int[][] matrix = matrixDot(matrixA, matrixB);
  for (int i = 0; i < matrix.length; i ++)printArray(matrix[i]);
}


int[][] matrixDot(int[][] matrix_m_n, int[][] matrix_n_k) {
  int m = matrix_m_n.length;
  int n = matrix_n_k.length;
  int k = matrix_n_k[0].length;
  int[][] matrix_m_k = new int[m][k];
  for (int j = 0; j < m; j ++) {
    for (int i = 0; i < k; i ++) {
      for (int _n = 0; _n < n; _n ++) {
        //matrix_m_n[0][m] ** matrix_n_k[m][0]
        matrix_m_k[j][i] += matrix_m_n[j][_n] * matrix_n_k[_n][i];
      }
    }
  }
  return matrix_m_k;
}
