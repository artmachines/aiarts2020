import com.runwayml.*;
RunwayHTTP runway;

boolean isHandInScreen = false;

JSONObject data;

void setup(){
  size(600,400);
  background(0);
  noStroke();
  runway = new RunwayHTTP(this);
}

void draw(){
  background(0);
  fill(255);
  rectMode(CENTER);
  draw_poses();
  //ModelUtils.drawPoseParts(data,g,10);
}

void runwayDataEvent(JSONObject runwayData){
  data = runwayData;
}

void draw_poses() {
  if (data != null) {
    JSONArray poses = data.getJSONArray("poses");
    
    for (int i = 0; i < poses.size(); i++) {
      // poses[i] :: poses.getJSONArray(i)
      JSONArray the_pose = poses.getJSONArray(i);
      
      JSONArray leftHand = the_pose.getJSONArray(9);
      float x0 = leftHand.getFloat(0) * width;
      float y0 = leftHand.getFloat(1) * height;
      ellipse(x0, y0, 10, 10);
      
      JSONArray rightHand = the_pose.getJSONArray(10);
      float x1 = rightHand.getFloat(0) * width;
      float y1 = rightHand.getFloat(1) * height;
      ellipse(x1, y1, 10, 10);
      
      if (
        0 < x0 &&
        x0 < width &&
        0 < y0 &&
        y0 < height &&
        0 < x1 &&
        x1 < width &&
        0 < y1 &&
        y1 < height
       ) {
         fill(255, 0, 255);
       }
      else if (0 < x0 && x0 < width && 0 < y0 && y0 < height) {
        fill(255, 0, 0);
      } else if (0 < x1 && x1 < width && 0 < y1 && y1 < height) {
        fill(0, 0, 255);
      } else {
        fill(255);
      }
        
      JSONArray leftEye = the_pose.getJSONArray(1);
      JSONArray nose = the_pose.getJSONArray(0);
      JSONArray rightEye = the_pose.getJSONArray(2);
      
      float pointX0 = leftEye.getFloat(0) * width;
      float pointX1 = nose.getFloat(0) * width;
      float pointX2 = rightEye.getFloat(0) * width;
      
      float pointY0 = leftEye.getFloat(1) * height;
      float pointY1 = nose.getFloat(1) * height;
      float pointY2 = rightEye.getFloat(1) * height;
      
      ellipse(pointX0, pointY0, 30, 15);
      ellipse(pointX1, pointY1, 15, 15);
      rect(pointX1, pointY1+35, 50, 15);
      ellipse(pointX2, pointY2, 30, 15);
    }
  }
}

void keyPressed() {
  print(data);
}
