#define which cells belong to the grain boundary

function [matrix] = grainBoundary(matrix, sizeMatrix)

matrix.boundary = zeros(sizeMatrix, sizeMatrix, sizeMatrix);       #to define which lattice belongs to the boundary
    
    for x=1:sizeMatrix
      for y=1:sizeMatrix
        for z=1:sizeMatrix
             
             if (matrix.boundary(x, y, z) != 1)     
                  
                  #neighbours in x
                  for i=x-1:x+1
                    
                    if (i<=0)
                      i = sizeMatrix+i;
                    endif
                  
                    if (i>sizeMatrix)
                      i=i-sizeMatrix;
                    endif
                    
                    j = y;
                    k = z;
                    matrix = visualizeNeighbour(matrix, sizeMatrix, x, y, z, i, j, k);
                    
                  endfor
                  
                  #neighbours in y
                  for j=y-1:y+1
                  
                    if (j<=0)
                      j = sizeMatrix+j;
                    endif
                    
                    if (j>sizeMatrix)
                      j=j-sizeMatrix;
                    endif
                      
                    i = x;
                    k = z;
                    matrix = visualizeNeighbour(matrix, sizeMatrix, x, y, z, i, j, k);
                  
                  endfor
                  
                  #neighbours in z
                  for k=z-1:z+1
                  
                    if (k<=0)
                      k = sizeMatrix+k;
                    endif
                    
                    if (k>sizeMatrix)
                      k=k-sizeMatrix;
                    endif
                          
                    i = x;
                    j = y;
                    matrix = visualizeNeighbour(matrix, sizeMatrix, x, y, z, i, j, k);
                  
                  endfor
              
              endif   
           
        endfor
      endfor
     endfor




endfunction


function [matrix] = visualizeNeighbour(matrix, sizeMatrix, x, y, z, i, j, k)

    if (i<1)
      i = sizeMatrix-i;
    endif
    if (j<1)
      j = sizeMatrix-j;
    endif
    if (k<1)
      k = sizeMatrix-k;
    endif
    if (i>sizeMatrix)
      i = i - sizeMatrix;
    endif
    if (j>sizeMatrix)
      j = j - sizeMatrix;
    endif
    if (k>sizeMatrix)
      k = k - sizeMatrix;
    endif

    #if the cells have different orientatio, thus being from different grains
    #they belong to the boundary

    if (matrix.orientation(x, y, z) != matrix.orientation(i, j, k))

      matrix.boundary(x, y, z) = 1;
      matrix.boundary(i, j, k) = 1;
      
    endif

endfunction