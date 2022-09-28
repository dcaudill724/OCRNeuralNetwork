//A layer will hold an array of neurons and hold the name of the previous layer.
//will also hold the x and y coordinates of the lay so it may be drawn.

class layer {
  neuron[] neurons;
  layer prevLayer;
  PVector pos;
  int w;
  int h;
  
  //hidden and output layer constructor
  layer(layer prevLayer, int size, int x){
    this.prevLayer = prevLayer;
    neurons = new neuron[size];
    pos = new PVector(x, height / 2 - size * nSize / 2);
    for(int i = 0; i < neurons.length; i++){
      neurons[i] = new neuron(prevLayer.neurons); 
    }
  }
  
  //input layer constructor
  layer(int w, int h){
     this.w = w;
     this.h = h;
     pos = new PVector(0, height / 2 - 14 * nSize / 2);
     neurons = new neuron[w * h];
     for(int i = 0; i < neurons.length; i++){
       neurons[i] = new neuron();
     }
  }
  //input layer fire function 
  void fire(card c){
    for(int i = 0; i < c.inputs.length; i++){
      neurons[i].output = c.inputs[i]; 
    }
  }
  
  //hidden and output layer fire function
  void fire(){
    for(neuron n : neurons){
      n.fire(); 
    }
  }
  
  void setError(float[] desired){
    for(int i = 0; i < desired.length; i++){
      neurons[i].setError(desired[i]); 
    }
  }
  
  void train(){
    for(neuron n : neurons){
      n.train(); 
    }
  }
  
  int getBestIndex(){
    int best = 0;
    float temp = -1.0;
    for(int i = 0; i < neurons.length; i++){
      if(neurons[i].output > temp){
         temp = neurons[i].output;
         best = i;
      }
    }
    return best;
  }
  
  void display(){
    //if input layer
    if(prevLayer == null){
      for(int i = 0; i < w; i++){
        for(int j = 0; j < h; j++){
           fill(map(neurons[i + j * w].output, -1.0, 1.0, 255, 0));
           rect(pos.x + nSize * i, pos.y + nSize * j, nSize - 2, nSize - 2);
        }
      }
    }
    
    //if hidden or output layer
    else {
      for(int i = 0; i < neurons.length; i++){
        fill(map(neurons[i].output, -1.0, 1.0, 255, 0));
        rect(pos.x, pos.y + nSize * i, nSize - 2, nSize - 2);
      }
    }
    
  }
}