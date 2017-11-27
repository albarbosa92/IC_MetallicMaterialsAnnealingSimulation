function [matrix] = calcEnergy (matrix, sizeMatrix)

    for x=1:sizeMatrix
      for y=1:sizeMatrix
        for z=1:sizeMatrix
      
         matrix = calcE(matrix, sizeMatrix, x, y, z); 
         printf(".");
          fflush(stdout);
        
        endfor
      endfor
     endfor

endfunction

function [matrix] = calcE(matrix, sizeMatrix, x, y, z)
  
  const = inputConst();
  J = const.J;
  
  count = 0;

    for i=x-1:x+1
      for j=y-1:y+1
        for k=z-1:z+1
          
            if (i==0)
              i = sizeMatrix;
            endif
            if (j==0)
              j = sizeMatrix;
            endif
            if (k==0)
              k = sizeMatrix;
            endif
            if (i==sizeMatrix+1)
              i=1;
            endif
            if (j==sizeMatrix+1)
              j=1;
            endif
            if (k==sizeMatrix+1)
              k=1;
            endif
          
            if (i!=x || j!=y || k!=z) #do not visualize the element that is being analyzed
              if (matrix.orientation(x, y, z) != matrix.orientation(i,j,k)) #if the each cell belongs to different grains
              
                count++;
                
              endif              
            endif
      
        endfor
      endfor
    endfor
    
    matrix.energy(x, y, z) = count*J; #energy in the cell is equal number of neighbours which belongs to diferrent grain times energy between 2 lattices

    endfunction