function [newList] = updateList(listOfCars, removed)

[listSize, junk] = size(listOfCars);
newListIndex = 1;
for i = 1:listSize
   if (removed(i) ~= 1)
       newList(newListIndex, 1:2) = listOfCars(i, 1:2);
       newListIndex = newListIndex+1;
   end
end
end