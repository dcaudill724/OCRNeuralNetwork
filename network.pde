int imageIndex = 0;

//This class stores and runs operations on all of the layers of the network
class network {
  int bestIndex = 0;
  card current;
  layer inputLayer;
  layer[] hiddenLayers;
  layer outputLayer;

  network(int hiddenLayerCount) {
    
    inputLayer = new layer(14, 14); //Init input layer
    
    //Init hidden layers
    hiddenLayers = new layer[hiddenLayerCount];
    for(int i = 0; i < hiddenLayerCount; i++){
      layer tempLayer;
      try{
        tempLayer = hiddenLayers[i - 1]; 
      } catch (ArrayIndexOutOfBoundsException e){
        tempLayer = inputLayer;
      }
      hiddenLayers[i] = new layer(tempLayer, 15, 400 + i * 50);
    }
    outputLayer = new layer (hiddenLayers[hiddenLayerCount - 1], 10, (int)hiddenLayers[hiddenLayerCount - 1].pos.x + 100); //Init output layer
  }

  //Run the network
  void forwardProp(card c) {
    inputLayer.fire(c);
    for (layer l : hiddenLayers) {
      l.fire();
    }
    outputLayer.fire();
    bestIndex = outputLayer.getBestIndex();
  }
  

  //Train the network
  void train(float[] outputs) {
    bestIndex = 0;
    outputLayer.setError(outputs);
    outputLayer.train();
    bestIndex = outputLayer.getBestIndex();
    for (layer l : hiddenLayers) {
      l.train();
    }
  }

  //Display the network
  void display() {
    inputLayer.display();
    for (layer l : hiddenLayers) {
      l.display();
    }
    outputLayer.display();
  }
  
  //Determine overall cost of the current forward prop
  float getCost(){
    float sum = 0;
    float count = 0;
    
    for(layer l : hiddenLayers){
      for(neuron n : l.neurons){
        sum += n.error * n.error;
        count++;
      }
    }
    
    for(neuron n : outputLayer.neurons){
       sum += n.error * n.error;
       count++;
    }
    
    
    return sum * 1.0/count;
  }
}
