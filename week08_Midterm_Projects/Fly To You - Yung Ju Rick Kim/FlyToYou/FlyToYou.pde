// ---------------------------------------------------------
// Initialize Variables
// ---------------------------------------------------------

// import video library
import processing.video.*;

// import Runway library
import com.runwayml.*;
// reference to runway instance
RunwayHTTP runway;

//Particles
ArrayList<Plane> planeList;
Plane pointA, pointB;
boolean isTriggered;

PImage runwayResult;
ArrayList<int[]> savedPositions;

// periocally to be updated using millis()
int lastMillis;
// how often should the above be updated and a time action take place ?
int waitTime = 15000;

// reference to the camera
Capture camera;

// status
String status = "waiting ~"+(waitTime/1000)+"s";

//----------------------------------------------------------

void setup(){
  size(600,400);
  
  // * Initialize Plane Array List
  planeList = new ArrayList<Plane>();
  
  // * Populate 1000 planes
  for (int i = 0; i < 1000; i++) {
    Plane newPoint = new Plane(random(width), random(height), random(width), random(height));
    planeList.add(newPoint);
  }
  
  // * RunwayML Setup Code
  String[] cameras = Capture.list();
  
  if (cameras == null) {
    println("Failed to retrieve the list of available cameras, will try the default...");
    camera = new Capture(this, 640, 480);
  } if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    printArray(cameras);
    
    // setup Runway
    runway = new RunwayHTTP(this);
    // update manually
    runway.setAutoUpdate(false);
    // setup camera
    camera = new Capture(this, cameras[0]);
    camera.start();
    // setup timer
    lastMillis = millis();
  }
}

void draw(){
  background(0);
  // update timer
  int currentMillis = millis();
  // if the difference between current millis and last time we checked past the wait time
  if(currentMillis - lastMillis >= waitTime){
    status = "sending image to Runway";
    // call the timed function
    sendFrameToRunway();
    // update lastMillis, preparing for another wait
    lastMillis = currentMillis;
    isTriggered  = true;
  }
  
  // * Array list that will hold the x, y positions of the denseDepth detected pixels
  savedPositions = new ArrayList<int[]>();
  
  // draw image received from Runway
  if(runwayResult != null){    
    
    // * Load the pixels of the received image
    loadPixels();
    runwayResult.loadPixels();
    
    // * Iterate through the pixels
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        int loc = x + y*width;
        
        float r = red(runwayResult.pixels[loc]);
        float g = green(runwayResult.pixels[loc]);
        float b = blue(runwayResult.pixels[loc]);
        
        // * Smaller the depth, lower the values for RGB
        // * So, 102 is the optimal value to select the closer depth
        if (r < 101 && g < 101 && b < 101)  {
          
          // * Save Position of the Detected Figure
          int[] position  = new int[2];
          position[0] = x;
          position[1] = y;
          savedPositions.add(position);
        } else {
          
          // * Change the color to white for the background (rest of the pixels)
          r = 255;
          g = 255;
          b = 255;
        }
        
        // * Update the pixels
        runwayResult.pixels[loc] =  color(r,g,b);          
      }
    }
    updatePixels();
    
    // * Load RunwayML processed image
    // image(runwayResult,0,0);
  }
  
  // * Initialize a count to serve as the index for accessing the savedPositions list randomly
  int count = 0;
  
  // * Loop Through the plane array list
  for (int i = 0; i < planeList.size()-1; i++){
    pointA = planeList.get(i);
    pointB = planeList.get(i+1);
    
    // * If there is a received image, the planes will move to a random positions in the savedPositions coordinates
    if (savedPositions.size() > 0 && isTriggered) {

      int[] savedPosition = savedPositions.get(count);
      pointA.updateDestination(savedPosition[0], savedPosition[1]);
      pointA.run();
      
      // * Replace the count with a random index within the savedPositions size
      count = (int) random(0, savedPositions.size()-1);
      
    } else {
            
      // * If the distance of the flying point A and B is smaller than 50, 
      // * and point A has smaller than magnitude of 50 between the destination,
      // * Display line connecting point A and B
      if (pointA.vector().dist(pointB.vector()) < 150 && pointA.directionMag() < 50) {
        int alphaC = (int)map(pointA.directionMag(), 100, 0, 0, 255);
        stroke(200, 150, 200, alphaC);
        line(pointA.x(), pointA.y(), pointB.x(), pointB.y());
      }
      pointA.run();
    }
  }
  
  // * Set isTriggered to false
  isTriggered = false;
  
  // display status
  text(status,5,15);
}

void sendFrameToRunway(){
  // nothing to send if there's no new camera data available
  if(camera.available() == false){
    return;
  }
  // read a new frame
  camera.read();
  // crop image to Runway input format (600x400)
  PImage image = camera.get(0,0,600,400);
  // query Runway
  runway.query(image);
}

// this is called when new Runway data is available
void runwayDataEvent(JSONObject runwayData){
  // point the sketch data to the Runway incoming data 
  String base64ImageString = runwayData.getString("depth_image");
  // try to decode the image from
  try{
    runwayResult = ModelUtils.fromBase64(base64ImageString);
  }catch(Exception e){
    e.printStackTrace();
  }
  status = "received runway result";
}

// this is called each time Processing connects to Runway
// Runway sends information about the current model
public void runwayInfoEvent(JSONObject info){
  println(info);
}
// if anything goes wrong
public void runwayErrorEvent(String message){
  println(message);
}
