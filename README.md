# canny-img-comparator
Comparing images using edges found by the Canny edge detection algorithm.

# Abstract
Today, large volumes of images are produced in various fields, including the web and mobile phones, which need to be
processed. One of these needs is to compare images with each other from different angles, such as the structure of 
objects in the image. Because there is information on the edges in every image, it is often necessary to find the edges.
For this purpose, various methods with different advantages, disadvantages and applications have been presented for
different years. The Canny method is one of the most standard and appropriate methods for identifying edges in various
applications. This project provides a way to compare images based on the edges found by the Canny edge detection
algorithm. For this purpose, an optimal implementation of the Canny method was performed and then the found edges were
compared with each other based on the Hausdorff distance criterion. Prior to edge detection and comparison, preprocessing
steps such as image preparation and dimensional normalization are performed. The proposed method has been tested on
standard images, and the NearDuplicate data set from Columbia University, and the results indicate that the method is 
suitable for applications that are designed to closely examine the structure of images.

# Repository Structure
The code has three main parts:
1. An implementation of Canny edge detection algorithm
2. An implementation of image similarity based on extracted edges and Hausdorff Distance
3. An implementation of search for one image in another image

Each of these sections has a code and user interface for easier testing.

``` text
.
├── docs
│   └── related files to documentations
├── output_1
│   └── the output directory
├── samples
│   └── famous standard image from Digital Image Processing book (by Rafael Gonzalez)
├── samples2
│   └── images from NearDuplicate dataset
├── canny.m
├── cannyEdgeDetectorParametersTest.m
├── compareCannyEdges.m
├── compareImages.m
├── dgauss.m
├── HausdorffDist.m
├── main.m
├── testCanny.m

```


# Samples
Testing Canny algorithm and its parameters vi GUI:
![Testing Canny algorithm and its parameters vi GUI](/docs/threshold-values.png "Testing Canny algorithm and its parameters vi GUI")

Images resulted from working with Canny parameters:

![Applying Canny edge detector with different parameters](/docs/canny-parameters-results.jpg "Applying Canny edge detector with different parameters")

Comparing two images using Canny edge detector and Hausdorff Distance:

![Comparing two images using Canny edge detector and Hausdorff Distance](/docs/compare-images-ui.png "Comparing two images using Canny edge detector and Hausdorff Distance")

An example of searching an image inside another image (sliding windows showed by red rectangles)
![An example of searching an image inside another image](/docs/image-search.tif "An example of searching an image inside another image")