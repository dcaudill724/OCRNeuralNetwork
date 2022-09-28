float LEARNING_RATE = 0.01;

class neuron {
  neuron[] inputs;
  float[] weights;
  float output;
  float error;

  neuron() {
    error = 0.0;
  }

  neuron(neuron[] inputNeurons) {
    inputs = new neuron[inputNeurons.length];
    weights = new float[inputNeurons.length];
    error = 0.0;
    for (int i = 0; i < inputNeurons.length; i++) {
      inputs[i] = inputNeurons[i];
      weights[i] = random(-1.0, 1.0);
    }
  }

  void fire() {
    float temp = 0;
    for (int i = 0; i < inputs.length; i++) {
      temp += inputs[i].output * weights[i];
    }
    output = lookupSigmoid(temp);
    error = 0.0;
  }

  void setError(float desired) {
    error = desired - output;
  }

  void train() {
    float delta = (1.0 - output) * (1.0 + output) * error * LEARNING_RATE;
    
    
    for (int i = 0; i < inputs.length; i++) {
      inputs[i].error += weights[i] * error;
      weights[i] += inputs[i].output * delta;
    }
  }
}