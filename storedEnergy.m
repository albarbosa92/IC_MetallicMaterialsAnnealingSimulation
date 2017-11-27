function [matrix] = storedEnergy(matrix, sizeMatrix, x, y, z)

      const = inputConst();
      v(const.numOrien) = 0;
      
      #for l=1:const.numOrien
      #    v(l) = 0;
      #endfor

      
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
                      
              #recrystallization can occur only when the neighbour cell is recrystalized
                
               if (i!=x || j!=y || k!=z)
                if (matrix.state(i, j, k) == 1) 
                  if (matrix.orientation(i,j,k)>0 && matrix.orientation(i,j,k)<=const.numOrien)
                  
                    aux = matrix.orientation(i,j,k);
                    aux2 = const.V;
                    v(aux) = v(aux) + aux2;
                    
                  endif   
                endif
               endif
              
                      
          endfor
        endfor
      endfor
   

  
   #find biggest value in the vector V and saves its values and position
  [vc, p] = max(v);

        if (matrix.nextOrient(x,y,z) == p)

          matrix.v(x, y, z) = matrix.v(x, y, z) + vc;
          #printf("\n1 %f\n", matrix.v(x, y, z));
          fflush(stdout);
        else
        
          #if stored energy recrystallization changes for other orientation, velocity goes to zero and restart counting
          #matrix.v(x, y, z) = 0;
          matrix.v(x, y, z) = (matrix.v(x, y, z) + vc);
          matrix.nextOrient(x,y,z) = p;
          #printf("\n2 %f\n", matrix.v(x, y, z));
          fflush(stdout);
          
        end
   
#{   
        if(matrix.v(x,y,z) >=1)
        
          matrix.orientation(x,y,z) = matrix.nextOrient(x,y,z);
          matrix.state(x, y, z) = 1;
          matrix.v(x,y,z) = 0;
        
        endif
 #}       
  matrix.v;
          fflush(stdout);


        
endfunction