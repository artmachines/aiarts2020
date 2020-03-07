// Copyright (C) 2020 RunwayML Examples
// 


// import Runway library
import com.runwayml.*;
RunwayHTTP runway;
JSONObject data;

void setup() {
  size(600, 400);
  runway = new RunwayHTTP(this);
}

void draw() {
  background(0);
  //ModelUtils.drawPoseParts(data,g,10);
  draw_poses();
}

void runwayDataEvent(JSONObject runwayData) {
  data = runwayData;
}

void draw_poses() {
  if (data != null) {
    JSONArray poses = data.getJSONArray("poses");
    print(poses);

    for ( int i = 0; i < poses.size(); i++) {
      //poses[i] :: poses.getJSONArray(i)

      JSONArray the_pose = poses.getJSONArray(i);

      for (int j = 0; j < the_pose.size(); j ++) {
        JSONArray point = the_pose.getJSONArray(j);

        JSONArray left = the_pose.getJSONArray(5);
        JSONArray right = the_pose.getJSONArray(6);
        JSONArray nose = the_pose.getJSONArray(0);

        float x = point.getFloat(0)*width;
        float y = point.getFloat(1)*height;

        float left_x = left.getFloat(0)*width;
        float right_x = right.getFloat(0)*width;
        float top = nose.getFloat(1)*height;

        if (top<150) {
          smooth();
          noStroke();
          fill(255, 0, 0);
          beginShape();
          vertex(50, 15);
          bezierVertex(50, -5, 90, 5, 50, 40);
          vertex(50, 15);
          bezierVertex(50, -5, 10, 5, 50, 40);
          endShape();
        }

        if (left_x<400) {
          stroke(255, 0, 0);
          strokeWeight(5);
          line(40, 0, 70, 25);
          stroke(255, 0, 0);
          strokeWeight(5);
          line(70, 0, 40, 25);
        } else if (right_x>300) {
          stroke(255, 0, 0);
          strokeWeight(5);
          line(540, 0, 570, 25);
          stroke(255, 0, 0);
          strokeWeight(5);
          line(570, 0, 540, 25);
        } 

        for (int k = 0; k < the_pose.size(); k ++) {
          JSONArray next_point = the_pose.getJSONArray(k);

          float next_x = next_point.getFloat(0)*width;
          float next_y = next_point.getFloat(1)*height;

          stroke(255, 255, 255);
          strokeWeight(2);
          line(x, y, next_x, next_y);
        }
      }
    }
  }
}

void keyPressed() {
  //print(data);
  draw_poses();
}
