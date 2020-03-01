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

```json
  {
  "scores": [0.393399521790664],
  "poses": [[
    [
      0.5714789077001787,
      0.4866840728062137
    ],
    [
      0.6080333462948929,
      0.40414391669665806
    ],
    [
      0.4907859540635046,
      0.40277047087130385
    ],
    [
      0.684059610974464,
      0.509903620189266
    ],
    [
      0.42625776060824266,
      0.48552613290831276
    ],
    [
      0.8382818485512344,
      0.9024627867375831
    ],
    [
      0.28463535828349196,
      0.8496557423112923
    ],
    [
      0.953369387392868,
      1.2934225356996294
    ],
    [
      0.04332311793524004,
      1.251044319297553
    ],
    [
      0.8049310246330291,
      1.3087925243006606
    ],
    [
      0.09733637390433583,
      1.112042853804414
    ],
    [
      0.6873751864822922,
      1.2128707768852147
    ],
    [
      0.31825622417583543,
      1.26854109856869
    ],
    [
      0.6895755190793643,
      1.2132942416788541
    ],
    [
      0.3211951163028465,
      1.2247794036271509
    ],
    [
      0.6944151583348731,
      1.2253813692567876
    ],
    [
      0.3362016881950171,
      1.2222375823366038
    ]
  ]]
}
```



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