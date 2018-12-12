data = load('fasterRCNNVehicleTrainingData.mat');
detector = data.detector;
listOfCars = zeros(1, 2);
    

folderName = 'scene1\';
sceneFolder = dir(folderName);
sceneNumOfFiles = length(sceneFolder);

videoOfImgs = cell(1, sceneNumOfFiles - 2); % num-2 b/c files 1&2 are '.' and '..'

for i=3:sceneNumOfFiles % start at 3 because files 1&2 are '.' and '..' in the directory
    curImgFilename = sceneFolder(i).name;
    curImgFilename = strcat(folderName, curImgFilename);
    videoOfImgs{i-2} = im2double(imread(curImgFilename));
end

%%%%%%%%%%%%%%%%%%% This is is the outputVideo data structure which will be used to build a video from images
outputVideoImgs = cell(1, size(videoOfImgs, 2)); 

[a, b] = size(videoOfImgs);
c1 = 650;
c2 = 1350;
c3 = 1270;
c4 = 700;
r1 = 1080;
r2 = 1080;
r3 = 750;
r4 = 760;

c = [ c1 c2 c3 c4]';
r = [ r1 r2 r3 r4]';
listOfCarsIndex = 1;
carsLeft = 0;
% for every frame in the image
for frameCount  = 1:b
origImage = videoOfImgs{frameCount};

% crop region to run CNN on
croppedImage = imcrop(origImage, [650 760 680 350]);

%get bounding boxes
[bbox, score, label] = detect(detector, croppedImage);

%convert values back from cropped image
[a, b] = size(bbox(:, 1:4));
for i = 1:a
    bbox(i, 1) = bbox(i, 1) + 650;
    bbox(i, 2) = bbox(i, 2) + 760;
end

%show image with bounding box
f1 = figure(1);
detectedImg = origImage;

%obtain bounding box centers
centers = obtainCenter(bbox);

imshow(detectedImg);
hold on;
plot([c;c(1)],[r;r(1)],'r','Linewidth',2);
for i = 1:a
  rectangle('Position',bbox(i, 1:4),'EdgeColor','g', 'Linewidth', 2)  ;
end
%%%%%%%%%%%%%%%%%%%%%%%%% Save current image with red box (region of interest) and green boxes (objects detected)
saveas(f1, 'lastFrame.png');
outputVideoImgs{1, frameCount} = imread('lastFrame.png');

% Tracking and Logging
[a,b] = size(centers);

hold off;
distanceThreshold = 45;

[listSize, junk] = size(listOfCars);

% for every center (j)
for j = 1:a
   centerInQuestion(1:2) = centers(j, 1:2); 
   % if the center in question is in the box
   if (((centerInQuestion(1) < 1230) && (centerInQuestion(1) > 750)) && ((centerInQuestion(2) < 1020) && (centerInQuestion(2) > 860)))
       % scan through the list of cars and try to find a match
            [listSize, junk] = size(listOfCars);
            placed = 0;
            for q = 1:listSize
                if (sqrt(((centerInQuestion(1) - listOfCars(q, 1))^2) + ((centerInQuestion(2) - listOfCars(q, 2))^2)) <= distanceThreshold)
                     listOfCars(q, 1:2) = centerInQuestion(1:2); 
                     placed = 1;
                end
            end
             % if not match, push back as new car
            if (placed == 0)
               listOfCars(listSize+1, 1:2) = centerInQuestion(1:2);
            end
   
   % else if not in the box
   else 
       placed = 0;
       [listSize, junk] = size(listOfCars);
       removed = zeros(listSize);
          for q = 1:listSize
                if (sqrt(((centerInQuestion(1) - listOfCars(q, 1))^2) + ((centerInQuestion(2) - listOfCars(q, 2))^2)) <= distanceThreshold)
                     listOfCars(q, 1:2) = centerInQuestion(1:2);
                     removed(1, q) = 1; 
                     carsLeft = carsLeft+1;
                end
          end
              listOfCars = updateList(listOfCars, removed);
     end
  end

end


%% Create Video from output object detected frames
% outputVideo variable contains the vehicle detected frames
% helpful link: https://www.mathworks.com/help/matlab/examples/convert-between-image-sequences-and-video.html 

outputVideo = VideoWriter('vehicleTracking.avi');
outputVideo.FrameRate = 15; % Ideally would not be a constant but the frame rate of the original input video
open(outputVideo);

for i=1:size(outputVideoImgs, 2)
    img = outputVideoImgs{1,i};
    writeVideo(outputVideo,img);
end

close(outputVideo);


