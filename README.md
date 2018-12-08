# Vechicle-Traffic-DetectionAndLogging
Summary: Computer vision based project. Detects vehicles within a specific area (or intersection) and logs the number of vehicles that have passed through it. Input is a traffic video. Output is a traffic video with a red box indicating the intersection (region of interest) and green boxes indicating the object detected.   


Problem: Want to determine the amount of traffic/congestion a certain area has. The amount of congestion an area has is based on the   number of vehicles that have traveled through that area for a certain time frame. This information is helpful in determining whether certain roads, intersections, areas in city, etc. are more dangerous than others. Given this information it will be much easier to determine if a certain intersection needs traffic lights or if the intersection already has traffic lights then a way to control traffic in a way that decreases the likelihood of an accident to occur. The idea was that if there were a a lot of cars in an intersection (or specific area) then the chances of an accident occurring increases exponentially which we would want to avoid. The basis of this project was obtaining that information indicating whether a certain intersection was dangerous. Then the application to decide what to do next with that information can be built on. Another example of this projects use would be obtaining the information of the number of vehicles that come in and out of a city. The information obtained in this project can also be branched out to decide less congested routes for autonomous vehicles.


Related Work: 


Approaches:
  1) Pre-trained CNN:
  
  2) HOG feature extractor: 
  
Approach Taken: The approach we decided to take is using the pre-trained CNN to get features from our training images.



Results/Analysis:



Conclusion:




Future Work:
One important aspect to work on for this project is determining the intersection (specific area) that we want to look at without having it predefined. This region of interest would ideally want to be determined by looking at the environment and choosing the most appropriate area to look at. Another addition we would like to add is the ability to distinguish between vehicles (cars, trucks, buses, motorcycles, vans, etc.) so then the data gathered is more informative. The issue was that it was difficult for us to find open source datasets for specific vehicles. Another addition would be not only detecting the vehicle within the intersection but also the speed. Knowing the speed of a vehicle can determine if that vehicle is increasing the risk of an accident within an intersection (region of interest) and labeling it as a dangerous vehicle.






