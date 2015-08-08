import processing.serial.*;
Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

// since we're doing serial handshaking, 
// we need to check if we've heard from the microcontroller
boolean firstContact = false;

void setup(){
  
// Open whatever port is the one you're using.
println(Serial.list());
size(200,200);
String portName = Serial.list()[3]; //change the 0 to a 1 or 2 etc. to match your port
myPort = new Serial(this, portName, 9600); 
myPort.bufferUntil('\n'); 

}

void draw()
{
  //if (mousePressed ==  true) 
  //{  // If data is available,
  ////val = myPort.readStringUntil('\n');         // read it and store it in val
  //  myPort.write("1");
    
  //} 
  //else{
  //  myPort.write("0");
  //}
//println(val); //print it out in the console
}
void serialEvent( Serial myPort) {
//put the incoming data into a String - 
//the '\n' is our end delimiter indicating the end of a complete packet
val = myPort.readStringUntil('\n');
//make sure our data isn't empty before continuing
if (val != null) {
  //trim whitespace and formatting characters (like carriage return)
  val = trim(val);
  println(val);

  //look for our 'A' string to start the handshake
  //if it's there, clear the buffer, and send a request for data
  if (firstContact == false) {
    if (val.equals("A")) {
      myPort.clear();
      firstContact = true;
      myPort.write("A");
      println("contact");
    }
  }
  else { //if we've already established contact, keep getting and parsing data
    println(val);

    if (mousePressed == true) 
    {                           //if we clicked in the window
      myPort.write('1');        //send a 1
      println("1");
    }

    // when you've parsed the data you have, ask for more:
    myPort.write("A");
    }
  }
}