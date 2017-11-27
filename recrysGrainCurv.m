function [matrix] = recrysGrainCurv(matrix, sizeMatrix, x, y, z)

 recrysLattice = true;

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
          
            if ((matrix.state(i, j, k)==1) && (matrix.orientation(i, j, k) != matrix.orientation(x, y, z))) #only if neighbours is recrystallized and it is from a different grain
              if(matrix.v(i, j, k)>matrix.v(x, y, z)) 
                  recrysLattice = false;
                break;
              endif
            endif
      
        endfor
      endfor
    endfor
    
    
    #if  lattice of interesrt has the biggest v, change its orientation and put its v to 0
    if(recrysLattice && matrix.nextOrient(x,y,z)!=0)
      matrix.orientation(x, y, z) = matrix.nextOrient(x, y, z);
      
    endif
           
endfunction