function [] = plotMatrix (matrix, sizeMatrix, header)

  range = linspace(1,sizeMatrix,sizeMatrix);
  [x,y,z] = meshgrid(range, range, range);

  xslice = [1,sizeMatrix]; 
  yslice = [1,sizeMatrix]; 
  zslice = [1,sizeMatrix];

  slice(matrix,xslice,yslice,zslice)
  
  title({header});
  
endfunction