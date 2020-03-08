// Copyright (C) 2020 RunwayML Examples
// 
// This file is part of RunwayML Examples.
// 
// Runway-Examples is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// Runway-Examples is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with RunwayML.  If not, see <http://www.gnu.org/licenses/>.
// 
// ===========================================================================

// RUNWAYML
// www.runwayml.com

// PoseNet Demo:
// Receive OSC messages from Runway
// Running PoseNet model
// original example by Anastasis Germanidis, adapted by George Profenza

// import Runway library
import com.runwayml.*;
import java.util.ArrayList;
// reference to runway instance
RunwayHTTP runway;

// This array will hold all the humans detected
JSONObject data;

float centerX, centerY;
float multVal = 1.2;
float rightEyeX, rightEyeY, leftEyeX, leftEyeY, eyeDist, 
eyeCenterX, eyeCenterY, mouthCenter;
float noseX;
float noseY;
float nosePointY;
float nosePointX;
float mouthY;
float mouthX;
float leftEarX;



void setup(){
  // match sketch size to default model camera setup
  size(600,400);
  // setup Runway
  runway = new RunwayHTTP(this);
  centerX = width/2;
  centerY = height/2;
}

void draw(){
  background(255);
  // use the utiliy class to draw PoseNet parts
  //ModelUtils.drawPoseParts(data,g,10);
  draw_poses();
  //rightEyeX = 250;
  //rightEyeY = 150;
  //leftEyeX = 350;
  //leftEyeY = 150;
  ////left eye == rightEye on Posenet
  //fill(255);
  //ellipse(rightEyeX, rightEyeY, 25, 10);
  //fill(0);
  //ellipse(rightEyeX, rightEyeY, 10, 10);
  ////right eye
  //fill(255);
  //ellipse(leftEyeX, leftEyeY, 25, 10);
  //fill(0);
  //ellipse(leftEyeX, leftEyeY, 10, 10);
  ////nose + mouth
  //eyeCenterX = (rightEyeX + leftEyeX)/2;
  //eyeCenterY = (rightEyeY + leftEyeY)/2;
  //eyeDist = dist(rightEyeX, rightEyeY, leftEyeX, leftEyeY);
  //float noseX = 300;
  //float noseY = 220;
  //float nosePointY = noseY + (eyeCenterY - noseY)*0.1;
  //float nosePointX = noseX - eyeDist/4;
  //line(eyeCenterX, eyeCenterY, nosePointX, nosePointY);
  //line(nosePointX, nosePointY, nosePointX + eyeDist/2, nosePointY);
  //float mouthY = noseY + (noseY - eyeCenterY)*.4;
  //float mouthX = noseX;
  //fill(255,30,30);
  //ellipse(mouthX, mouthY, eyeDist/2, 20);
  //float leftEarX = 200;
  //line(leftEarX, leftEyeY, leftEarX + (mouthX-leftEarX)*.2, mouthY);
  //line(leftEarX + (mouthX-leftEarX)*.2, mouthY, mouthX, mouthY + (mouthY-noseY));
}

// this is called when new Runway data is available
void runwayDataEvent(JSONObject runwayData){
  // point the sketch data to the Runway incoming data 
  data = runwayData;
}

void draw_poses() {
  if(data != null){
    JSONArray poses = data.getJSONArray("poses");
    print(poses.getJSONArray(0));
    
    //lets assume we have multi poses
    for (int i = 0; i < poses.size(); i++){
      JSONArray the_pose = poses.getJSONArray(i);
      // 0: nose, 1: rightEye, 2: leftEye, 4: leftEar
      
      //rightEye
      JSONArray rightEye = the_pose.getJSONArray(1);
      float rightEyeX = extractX(rightEye);
      float rightEyeY = extractY(rightEye);
      fill(255);
      ellipse(rightEyeX, rightEyeY, 37.5, 15);
      fill(0);
      ellipse(rightEyeX, rightEyeY, 15, 15);
      
      //leftEye
      JSONArray leftEye = the_pose.getJSONArray(2);
      float leftEyeX = extractX(leftEye);
      float leftEyeY = extractY(leftEye);
      fill(255);
      ellipse(leftEyeX, leftEyeY, 37.5, 15);
      fill(0);
      ellipse(leftEyeX, leftEyeY, 15, 15);
          
      //nose
      JSONArray nose = the_pose.getJSONArray(0);
      eyeCenterX = (rightEyeX + leftEyeX)/2;
      eyeCenterY = (rightEyeY + leftEyeY)/2;
      eyeDist = dist(rightEyeX, rightEyeY, leftEyeX, leftEyeY);
      noseX = extractX(nose);
      noseY = extractY(nose);
      nosePointY = noseY + (eyeCenterY - noseY)*0.1;
      nosePointX = noseX - eyeDist/4;
      line(eyeCenterX, eyeCenterY, nosePointX, nosePointY);
      line(nosePointX, nosePointY, nosePointX + eyeDist/2, nosePointY);
      mouthY = noseY + (noseY - eyeCenterY)*.4;
      mouthX = noseX;
      fill(255,30,30);
      ellipse(mouthX, mouthY, eyeDist/2, 20);
      
      //leftEar
      JSONArray ear = the_pose.getJSONArray(4);
      float leftEarX = extractX(ear);
      line(leftEarX, leftEyeY, leftEarX + (mouthX-leftEarX)*.2, mouthY);
      line(leftEarX + (mouthX-leftEarX)*.2, mouthY, mouthX, mouthY + (mouthY-noseY));
      
      //let's look into pos/points
      //for (int j = 0; j < 5 & j != 3 ; j++){
      //  //accessing to the point/pos
      //  JSONArray point = the_pose.getJSONArray(j);
        
      //  float x = point.getFloat(0)*width;
      //  float y = point.getFloat(1)*height;

      //  if(j == 0){
      //    fill(255,0,0);
      //    ellipse(x,y,20,20);
      //  }
      //  if(j == 1){
      //    fill(0,255,0);
      //    ellipse(x,y,20,20);
      //  }
      //  if(j == 2){
      //    fill(0,0,255);
      //    ellipse(x,y,20,20);
      //  }
      //  if(j == 3){
      //    fill(255,255,0);
      //    ellipse(x,y,20,20);
      //  }
      }
    }
  }

float scalePoint(float center, float point) {
  float scaled = center + (point-center)*multVal;
  return scaled;
}

float extractX(JSONArray part) {
  float X = scalePoint(centerX, part.getFloat(0)*width);
  return X;
}

float extractY(JSONArray part) {
  float Y = scalePoint(centerX, part.getFloat(1)*height);
  return Y;
}

void keyPressed() {
  //print(data);
  //draw_poses();
}
