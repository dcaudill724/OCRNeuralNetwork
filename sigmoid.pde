float[] sigmoid = new float[200];

void initSigmoid() {
  for (int i = 0; i < 200; i++) {
    float x = (i / 20.0) - 5.0;
    sigmoid[i] = 2.0 / (1.0 + exp(-2.0 * x)) - 1.0;
  }
}

// once the sigmoid has been set up, this function accesses it:
float lookupSigmoid(float x) {
  return sigmoid[constrain((int)floor((x + 5.0) * 20.0), 0, 199)];
}
