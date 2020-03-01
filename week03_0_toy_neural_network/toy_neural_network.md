## Perceptron

* what is a perceptron? 

* ![perceptron](https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Perceptron.svg/500px-Perceptron.svg.png)

* classification

* ![classification](https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Perceptron_example.svg/500px-Perceptron_example.svg.png)

## Let's code, step by step:

1. data: point with color
    * position (x, y)
    * color black or white, denoted as 0 or 1

2. define the task: the toy neural network predict color with only position information as input

3. construct the perceptron: forward pass (like guessing)
    1. weights
    2. sum
    3. activation
    4. sign()

4. construct the perceptron: backward propagation, aka. training
    1. steering
    2. update weights with error

5. train and visualize
    1. sampling the training sample
    2. control the leanring rate
    3. oscillating 

