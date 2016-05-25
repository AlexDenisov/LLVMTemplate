int find_max(int a[], int N) {
  int max = a[0];
  for (int i = 1; i < N; i++) {
    int cur = a[i];
    if (cur > max) {
      max = cur;
    }
  }

  return max;
}

