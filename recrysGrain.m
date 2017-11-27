function [matrix] = recrysGrain(matrix, sizeMatrix, x, y, z)

 
    
    
    #if  lattice of interesrt has the biggest v, change its orientation and put its v to 0
    if(recrysLattice && matrix.nextOrient(x,y,z)!=0)
      matrix.orientation(x, y, z) = matrix.nextOrient(x, y, z);
      
    endif
           
endfunction