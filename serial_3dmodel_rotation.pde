//This program should receives ','separated float value 0.0~1.0
//ex) 1.000000,0.98760,
import processing.serial.*;
Serial myPort;  // Create object from Serial class
float val;      // Data received from the serial port
int counter = 0;// Timer counter

void setup() {
  size(640, 480, P3D);
  String portName = Serial.list()[2]; // ex) /dev/tty.usbmodem
  myPort = new Serial(this, portName, 9600);
}

//return 0.9~1.0
float getTimer() {
  counter++;
  float val = sin(counter*PI/50)/20 + 0.95;  
  if (counter == 100) counter=0;
  return val;
}

void draw() {
  if (myPort.available() > 8) {                // If 9byte or more data exists
    String buf = myPort.readStringUntil(',');  // Read 1 float value
    buf = buf.split(",")[0];                   // Remove ","
    println(buf);
    val =float(buf);

    //3D draw
    background(255);
    camera(0.0, 150.0, 400.0, 0.0, 0.0, 0.0, 
    0.0, 1.0, 0.0);
    //push and pop
    pushMatrix();
    scale(getTimer());
    //analogin text
    text(val, -20, -80, 150);
    //sphere unit
    rotateY(2*PI*val);//rad
    directionalLight(250, 230, 230, 0, 0, -1);
    directionalLight(200, 230, 250, 0, 0, 1);
    ////sphere
    fill(255);
    stroke(255);
    sphereDetail(12);
    sphere(140);
    ////text
    fill(0);
    text("Workshop", 0, 0, 150);
    popMatrix();
  }
}

