int fib(int n) {
  // base cases
  if (n <= 2) {
    return 1;
  }

  return fib(n - 1) + fib(n - 2);
}

