card [] testing_set; //2000 cards
card [] training_set; //8000 cards

//This class stores the image data as well as the formatted output data
class card {

  float [] inputs; //image data
  float [] outputs; //Ouput data with one hot encoding
  int output; //Output as int
  
  card() {
    inputs = new float [196]; //Image is 14x14
    outputs = new float[10]; //Output is 0-9
  }

  //Load the image data
  void imageLoad(byte [] images, int offset) {
    for (int i = 0; i < 196; i++) {
      inputs[i] = int(images[i+offset]) / 128.0 - 1.0; //Store each pixel as value between 0-1 based on grayscale value between 0-255
    }
  }

  //Load the label data
  void labelLoad(byte [] labels, int offset) {

    output = int(labels[offset]); //Get the label as an int
    
    //Set the corresponding value in the one hot output array to 1 and setting everything else to -1
    for (int i = 0; i < 10; i++) { 
      if (i == output) {
        outputs[i] = 1.0;
      } else {
        outputs[i] = -1.0;
      }
    }
  }
  
}

//Load the data into the cards
void loadData(){
  
  byte [] images = loadBytes("t10k-images-14x14.idx3-ubyte");
  byte [] labels = loadBytes("t10k-labels.idx1-ubyte");
  
  training_set = new card [8000];
  int tr_pos = 0;
  
  testing_set = new card [2000];
  int te_pos = 0;
  
  for (int i = 0; i < 10000; i++) {
    if (i % 5 != 0) { 
      training_set[tr_pos] = new card();
      training_set[tr_pos].imageLoad(images, 16 + i * 196); // There is an offset of 16 bytes
      training_set[tr_pos].labelLoad(labels, 8 + i);  // There is an offset of 8 bytes
      tr_pos++;
    } else {
      testing_set[te_pos] = new card();
      testing_set[te_pos].imageLoad(images, 16 + i * 196);  // There is an offset of 16 bytes 
      testing_set[te_pos].labelLoad(labels, 8 + i);  // There is an offset of 8 bytes
      te_pos++;
    }
  }
}
