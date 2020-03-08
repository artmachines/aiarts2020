import com.runwayml.*;
RunwayHTTP runway;
JSONObject data;

JSONArray the_x = new JSONArray();
JSONArray the_y = new JSONArray();
color c = color(150, 115, 85);


void setup() {
  size(600, 400);
  runway = new RunwayHTTP(this);
  stroke(255, 0, 0);
  strokeWeight(2);
}

void draw() {
  background(0);
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
      JSONArray the_pose = poses.getJSONArray(i);
      
      //lets look into pos/points
      for (int j = 0; j < the_pose.size(); j ++) {
        //accessing to the point/pos
        /*[
         0.5714789077001787,
         0.4866840728062137
         ]*/
        JSONArray point = the_pose.getJSONArray(j);
        float x = (1 - point.getFloat(0))*width;
        float y = point.getFloat(1)*height;
        the_x.setFloat(j, x);
        the_y.setFloat(j, y);
      }
      fill(c);
      beginShape();
      vertex(the_x.getFloat(1), the_y.getFloat(1));
      vertex(the_x.getFloat(2), the_y.getFloat(2));
      vertex(the_x.getFloat(4), the_y.getFloat(4));
      vertex(the_x.getFloat(0), the_y.getFloat(0));
      vertex(the_x.getFloat(3), the_y.getFloat(3));
      endShape(CLOSE);
      beginShape();
      vertex(the_x.getFloat(5), the_y.getFloat(5));
      vertex(the_x.getFloat(6), the_y.getFloat(6));
      vertex(the_x.getFloat(12), the_y.getFloat(12));
      vertex(the_x.getFloat(11), the_y.getFloat(11));
      endShape(CLOSE);
      stroke(c);
      strokeWeight(20);
      line(the_x.getFloat(5), the_y.getFloat(5), the_x.getFloat(7), the_y.getFloat(7));
      line(the_x.getFloat(7), the_y.getFloat(7), the_x.getFloat(9), the_y.getFloat(9));
      line(the_x.getFloat(6), the_y.getFloat(6), the_x.getFloat(8), the_y.getFloat(8));
      line(the_x.getFloat(8), the_y.getFloat(8), the_x.getFloat(10), the_y.getFloat(10));
      line(the_x.getFloat(11), the_y.getFloat(11), the_x.getFloat(13), the_y.getFloat(13));
      line(the_x.getFloat(13), the_y.getFloat(13), the_x.getFloat(15), the_y.getFloat(15));
      line(the_x.getFloat(12), the_y.getFloat(12), the_x.getFloat(14), the_y.getFloat(14));
      line(the_x.getFloat(14), the_y.getFloat(14), the_x.getFloat(16), the_y.getFloat(16));
      noStroke();
      for (int k = 5; k < the_x.size(); k++){
        float x = the_x.getFloat(k);
        float y = the_y.getFloat(k);
        stroke(255);
        strokeWeight(3);
        line(x, 0, x, y);
        noStroke();
        fill(0);
        ellipse(x, y, 60, 60);
        fill(c);
        ellipse(x, y, 45, 45);
        fill(255);
        ellipse(x, y, 30, 30);
      }
    }
   }
}
