function [matrix, grainSize] = calcVolume(matrix, sizeMatrix)

modelSize = sizeMatrix^3;
counted = 0;
grainCount = 1;
aux = 1;
aux2 = 1;
grainSize = 0;

fflush(stdout);

  do    
      
      global count = 0;
      
          for x=1:sizeMatrix
            for y=1:sizeMatrix
              for z=1:sizeMatrix
                
                if ((matrix.count(x, y, z) == 0) && (matrix.state(x, y, z) == 1))
                
                count = 0;
                
                  aux = counted;
                  
                  matrix.count(x, y, z) = aux2;
                  counted = counted + 1;
                  
                  #calls function to analyze neighbourhood and identify lattice that belongs to the same grain
                  [matrix, counted] = analyzeNeighbour(matrix, sizeMatrix, x, y, z, counted);
                  
                  
                  
                  
                  if(grainCount==1)
                    grainSize = counted;
                  elseif(grainCount>1)
                    grainCount = [grainCount, (counted-aux)];
                  end
                  
                  
                  
                  grainCount = grainCount +1;
                  aux2 = aux2 +1;
                  
                endif 
                
              
              endfor
            endfor
           endfor
           
  until (counted >= modelSize)
 
endfunction
 
 
function [matrix, counted] = analyzeNeighbour(matrix, sizeMatrix, x, y, z, counted);

global count = 0;

modelSize = sizeMatrix^3;
max_recursion_depth (modelSize, "local");

    for i=x-1:x+1
        for j=y-1:y+1
          for k=z-1:z+1
            
              if (i<=0)
                i = sizeMatrix+i;
              endif
              if (j<=0)
                j = sizeMatrix+j;
              endif
              if (k<=0)
                k = sizeMatrix+k;
              endif
              if (i>sizeMatrix)
                i=i-sizeMatrix;
              endif
              if (j>sizeMatrix)
                j=j-sizeMatrix;
              endif
              if (k>sizeMatrix)
                k=k-sizeMatrix;
              endif  
        
                if ((matrix.count(i, j, k) == 0)&& (matrix.state(x, y, z) == 1))
                  if ((matrix.orientation(i, j, k) == matrix.orientation(x, y, z))) 
              
                    matrix.count(i, j, k) =  matrix.count(x, y, z);
                    counted = counted + 1;
           
                    
                    count += 1;
                    
                    [matrix, counted] = analyzeNeighbour(matrix, sizeMatrix, i, j, k, counted);

                  endif
                endif
        
            endfor
        endfor
    endfor
    
    if (count> 2*modelSize)
    
      break;
      
    endif

        
        
      
            
   

  

endfunction