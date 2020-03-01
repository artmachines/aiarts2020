## software we need:

- Processing 3
  - OSC library
  - runwayML library

- runwayML
  - docker
  - setup posenet to run locally

## we will try:

- Processing <--> OSC <--> runwayML

- Processing <--> runwayML(OSC) <--> runwayML
  
- Processing <--> runwayML(http) <--> runwayML

## structure of posenet:

- poses
  - keypoints
    - (x, y) (relative to width, height [0,1])



## in case you updated your mac OSX and find the video library problem

(I am surprised there is no official fix). What learned from this github [issue](https://github.com/processing/processing-video/issues/134)

* a solution --> manually update the video library:

    1. Download the latest video library from the [releases page](https://github.com/processing/processing-video/releases). (I tried version 2.0-beta4 worked for me.)

    2. Unzip the folder into ~/Documents/Processing/libraries. (Remove the existing video folder if it's there)
    
    3. Open the Terminal, type cd and space then dragging in the video library folder. Then press enter. It should look like this:
        ``` bash
        cd /Users/YOUR_USER_NAME/Documents/Processing/libraries/video
        ```
    
    4. Delete the quarantine flag. Continue in terminal:
        ``` bash
        xattr -r -d com.apple.quarantine *
        ```

    5. Restart Processing.

* result: 
    1. The basic GettingStartedCapture example should work immediately. 
    2. All other examples require an extra step: specify the cameras from the Capture.list(), for instance: 
   
    ``` processing
    // old
    video = new Capture(this, 640, 480);
    ```
    
    ``` processing
    // new
    String[] cameras = Capture.list();
    video = new Capture(this, 640, 480, cameras[0]);
    ```