network n;
card current;
int nSize = 25;

//Main functions
void setup() {
  size(1000, 500);
  
  //Init data
  initSigmoid();
  loadData();
  
  n = new network(1);
  current = training_set[(int)random(0, testing_set.length)]; //Select random card
  
  //Run initial forward propagation
  n.forwardProp(current);
}

void draw() {
  background(200);
  
  n.display();
  displayOutputText();
}




//Custom methods
void displayOutputText() {
  fill(255);
  textSize(40);
  textAlign(RIGHT, TOP);
  text("ouput: " + n.bestIndex, width - 10, 10);
  text("expected: " + current.output, width - 10, 50);
  text("cost: " + n.getCost(), width - 10, 90);
}




//Built-in Methods
void keyPressed() {
  
  //Press t train
  if (key == 't') {
    for(int i = 0; i < 5000; i++){
      current = testing_set[(int)random(0, testing_set.length)]; //Select random card
      n.forwardProp(current);
      n.train(current.outputs);
    }
  }
  
  //Press space to test
  if (key == ' ') {
    current = training_set[(int)random(0, training_set.length)];
    n.forwardProp(current);
  }
  
}
