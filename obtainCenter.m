function [centers] = obtainCenter(bbox)
[rows, columns] = size(bbox);
centers = zeros(rows, 2);

%for every bounding box, store the center in "centers"
for i = 1:rows
   cornerX = bbox(i,1);
   cornerY = bbox(i, 2);
   distX = bbox(i, 3);
   distY = bbox(i, 4);
   centers(i, 1:2) = [cornerX + floor(distX/2), cornerY + floor(distY/2)];
end
end