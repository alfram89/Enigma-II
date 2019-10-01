function array = RowChange(array, row1, row2)
  array([row2, row1], :) = array([row1, row2], :);
%   A function to just change rows inside a matrix.