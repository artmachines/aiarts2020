
// original example by Anastasis Germanidis, adapted by George Profenza, 
//RUNWAYML, www.runwayml.com
// adapted by aven (https://www.aven.cc)
// artMahcines & NYU Shanghai
// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020

import com.runwayml.*;
RunwayHTTP runway;
JSONObject data;

void setup() {
  size(600, 400);
  runway = new RunwayHTTP(this);
}

void draw() {
  background(0);
  //ModelUtils.drawPoseParts(data, g, 10);
  draw_poses();
}

void runwayDataEvent(JSONObject runwayData) { //event listener
  data = runwayData;
}

void draw_poses() {
  if (data != null) {
    JSONArray poses = data.getJSONArray("poses");
    print(poses);

    //lets assume we have multi poses
    for (int i = 0; i < poses.size(); i ++) {
      //poses[i] :: poses.getJSONArray(i)
      // focus one specific pose
      JSONArray the_pose = poses.getJSONArray(i);

      //lets look into pos/points
      for (int j = 0; j < the_pose.size(); j ++) {
        //accessing to the point/pos
        /*[
         0.5714789077001787,
         0.4866840728062137
         ]*/
        JSONArray point = the_pose.getJSONArray(j);

        float x = point.getFloat(0)*width;
        float y = point.getFloat(1)*height;

        fill(255);
        ellipse(x, y, 15, 15);

        if (j == 0) {
          fill(255, 0, 0);
          ellipse(x, y, 40, 40);
        }
      }
      /*
      JSONArray point = the_pose.getJSONArray(0);
      float x = point.getFloat(0)*width;
      float y = point.getFloat(1)*height;
      fill(255, 0, 0);
      ellipse(x, y, 40, 40);
      */
    }
  }
}

void keyPressed() {
  //print(data);
  draw_poses();
}
