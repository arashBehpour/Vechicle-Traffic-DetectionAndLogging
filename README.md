# Vechicle-Traffic-DetectionAndLogging
Summary: 

   Computer vision based project. Detects vehicles within a specific area (or intersection) and logs the number of vehicles that have passed through it. Input is a traffic video. Output is a traffic video with a red box indicating the intersection (region of interest) and green boxes indicating the object detected.   


Problem: 
    
   Want to determine the amount of traffic/congestion a certain area has. The amount of congestion an area has is based on the   number of vehicles that have traveled through that area for a certain time frame. This information is helpful in determining whether certain roads, intersections, areas in city, etc. are more dangerous than others. Given this information it will be much easier to determine if a certain intersection needs traffic lights or if the intersection already has traffic lights then a way to control traffic in a way that decreases the likelihood of an accident to occur. The idea was that if there were a a lot of cars in an intersection (or specific area) then the chances of an accident occurring increases exponentially which we would want to avoid. The basis of this project was obtaining that information indicating whether a certain intersection was dangerous. Then the application to decide what to do next with that information can be built on. Another example of this projects use would be obtaining the information of the number of vehicles that come in and out of a city. The information obtained in this project can also be branched out to decide less congested routes for autonomous vehicles.


Related Work: 

   “Honda Motor Co., the small town of Marysville and the state of Ohio are joining forces to solve one of the many puzzles facing the future of mobility: how to avoid accidents at intersections, where traffic and pedestrians often collide with disastrous, and often fatal, outcomes “.  Honda uses a V-to-X (vehicle-to-everything) technology that uses information (in the form of radio signals) about an upcoming intersection to give the driver a warning “heads-up” display to indicate extra caution in that area. The cars will log and report each time It receives a warning. Honda also believes that this technology will lead to a smarter and safer transportation ecosystem that can be a key role in achieving a zero-collision society. This research initiative in the city of Marysville is believed to help give a better understanding on how V-to-X technologies can be further developed to benefit all road users. The focus for these technologies would be in urban intersections. In urban intersections it is difficult to use sensing technologies (radar, cameras, and LIDAR) around corners blocked by buildings. 
   
   Source: https://www.forbes.com/sites/doronlevin/2018/10/08/honda-smart-intersection-a-step-toward-driverless-future-with-fewer-accidents-fatalities/#32cd8adac0fa 


Approaches(note: Both require training images):
    
   1) Pre-trained CNN: This approach for feature extraction uses a convolutional neural network that requires training images to extract an objects features. A convolutional neural network's (CNN) effectiveness would stem from accurate feature extraction from its training images. When selecting training images, you want to pick good quality images, evened out samples of each object, and limit the number of poor features being extracted. Different neural networks have different number of layers that are used to train images. Layers in a CNN usually consist of convolutional and pooling layers on the images being trained on. There are a lot of different pre-trained neural networks available to be used. An example of a neural network we used (alexnet) can be found here https://www.mathworks.com/help/deeplearning/ref/alexnet.html
  
   2) HOG feature extractor: This approach for feature extraction divides an image into several sub blocks (images) and takes the   gradient of variation in a different number of orientations. The gradient would be the variation in color and the interest of this algorihtim would be in the magnitude of a pixel in a particular orientation. If this approach is implemented a classfication method for detecting objects within an image can be through the sliding window algorithim. In general the sliding window algorithim attempts to detect different sized objects using different sized windows that compares the windows features with the features gathered from the HOG. More information about the HOG approach can be found on https://www.learnopencv.com/histogram-of-oriented-gradients/ 
  
Approach Taken: 
    
   The approach we decided to take is using the pre-trained CNN to get features from our training images. Specifically, we chose training a region based convolutional neural network (RCNN). By training an RCNN the feature extraction and classification merged into one. The reason is because a CNN is used to extract features while then requiring a classification step. However, by using a RCNN we can label the objects (vehicles) within our training images to be more descriptive. Each training image would have bounding boxes that indicate the specific object (vehicle) in that image. This neural network will be used to develop our detector of objects within images. Using this detector and a random test image we can detect the object we are looking for within that test image. 
   To make this process smoother an option we considered was to perform a perspective transform. This would allow us to take any view from a traffic camera and turn it to a top down view for easier detection. The reason we did not implement this is because we were able to detect a good percentage of vehicles without the perspective transform. However, Ideally the best way to increase the accuracy of detecting vehicles in an image would be to compare the results of objects being detected in different viewpoints. This is also another way to avoid detecting false positives within an image. 
   The next step to solving our problem would then be tracking and logging the vehicles that travel within the region of interest. To track the vehicles, we implemented a data structure (list of cars) that would contain information on the specific cars that were currently within our region of interest. The way we kept track of each vehicle was simply based on the cars center of location within the objects bounding box. The way we were able to log each vehicle is when the vehicle went out of scope within the region of interest. This can be determined if the previously tracked vehicle (in the list of cars) could not be identified in the current detected vehicles frame.


Results/Analysis:

   The results of our tracking algorithm combined with our CNN detection are shown in a video linked on our website. The green boxes are cars detected and counted as they leave the image. While the implementation does correctly count cars as they leave the box, there are some aspects that can be improved. Because we were not able to add our own dataset and had to use the pre-trained Matlab vehicle CNN, buses and large cars are often identified as multiple cars. This leads to false positives which incremented the count of cars to a much greater number than expected. This issue is shown in the Object Detection Error above, in which the bus is counted as five cars. When a car enters the blue box, it is added to a list. A car is only counted as having left the intersection if it has been added to the list and is found outside the blue box and in the red box.  This stops cars from being counted twice as they pass through the roadway by only tracking cars which are detected passing through it (as opposed to in it). Additionally, this adds further flexibility in that the number of cars in each direction could be counted, if the algorithm were to be expanded. Were the CNN detection improved, we expect the tracking algorithm would perform very well. While the Perspective Transform could be a useful tool for improving car detection and visualizing the results of this algorithm, we were unable to achieve the desired results.


Conclusion:

   Our results show that the project correctly detects and logs a lot of the cars that pass through the roadway. The project is, however, not ready to be used on a large scale intersection or long-term video. Significant improvements need to be made to the detection's accuracy. If we were able to correctly train our RCNN with a larger training set then our vehicle detection portion of the project would have resulted in a much higher accuracy in vehicles detected. This project is a success in that it provides a good basis for an implementation of vehicle detection and logging using computer vision. Some additional changes are described in the future work section which would greatly increase the lifetime of our vehicle detection and logging algorithm.   


Future Work:

   One important aspect to work on for this project is determining the intersection (specific area) that we want to look at without having it predefined. This region of interest would ideally want to be determined by looking at the environment and choosing the most appropriate area to look at. Another addition we would like to add is the ability to distinguish between vehicles (cars, trucks, buses, motorcycles, vans, etc.) so then the data gathered is more descriptive. The issue was that it was difficult for us to find open source datasets for specific vehicles. With the aspect of making the data gathered more descriptive, the direction that the vehicle left the region of interest could also be included. Another addition would be not only detecting the vehicle within the intersection but also the speed. Knowing the speed of a vehicle can determine if that vehicle is increasing the risk of an accident within an intersection (region of interest) and labeling it as a dangerous vehicle.






