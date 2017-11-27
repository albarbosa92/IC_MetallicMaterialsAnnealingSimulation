function [matrix, sizeMatrix] = defineMatrix

  const = inputConst;
  sizeMatrix = const.size;
  
  sizeX = sizeMatrix;
  sizeY = sizeMatrix;
  sizeZ = sizeMatrix;
  
  #creating matrix and its properties
  matrix.state = zeros(sizeX, sizeY, sizeZ);          #if crystallyzed or not
  matrix.orientation = zeros(sizeX, sizeY, sizeZ);    #the orientation of  the lattice
  matrix.energy = zeros(sizeX, sizeY, sizeZ);         #energy in the lattice
  matrix.v = zeros(sizeX, sizeY, sizeZ);              #velocity of nucleation
  matrix.count = zeros(sizeX, sizeY, sizeZ);          #to count volume of the grains
  matrix.boundary = zeros(sizeX, sizeY, sizeZ);       #to define which lattice belongs to the boundary
  matrix.nextOrient = zeros(sizeX, sizeY, sizeZ);     #Next orientation lattice can take
  #matrix.RX = zeros(sizeX, sizeY, sizeZ);             #level of coverage of the the particular cell

  #number of lattice
  
  modelSize = (sizeMatrix)^3;
  
  #number of nuclei for the first matrix
  p = const.nuclei;      

  #number of crystallized cells

  crystCells = 0;  
 
  
  #allocate first nuclei
  printf("First Nucleation DMR\n\n")
  ctime(time) 
  
  while p>0
  
    x = randi (sizeMatrix,1,1);
    y = randi (sizeMatrix,1,1);
    z = randi (sizeMatrix,1,1);  
  
 
    
    if (matrix.state(x, y, z) != 1)
      
        do 
          aux = randi(const.numOrien,1,1);
          matrix.state(x, y, z) = 1;
          matrix.orientation (x, y, z) = aux;
          
        until (aux>0)
        
        p--;
        crystCells = crystCells + 1;
    endif
    
    #percentage recrystallized
    #percCryst = crystCells/modelSize;
 
    #printf ("%.3f\n", percCryst);
    
    #fflush(stdout);
    
    
    
    
  endwhile
  
  printf("\nGrain Growth DMR\n\n")
ctime(time)
  
  #grow first grains
  auxMatrix = matrix;
  
  
  
 do
  
  crystCells = 0;
  
     for x=1:sizeMatrix
      for y=1:sizeMatrix
        for z=1:sizeMatrix
          
          if ((matrix.state(x, y, z) == 1)&&(matrix.orientation(x, y, z)!=0)) #only if the main cell is equal of 1 
        
            [auxMatrix] = firstGrainGrowth(matrix, auxMatrix, sizeMatrix, x, y, z); 
            
         
            
      
          
          elseif((matrix.state(x, y, z) == 1)&& (matrix.orientation(x, y, z)==0))
            
            matrix.state(x, y, z) =0;
            
          end
          
        endfor
      endfor
     endfor
     
     
     #to count the recrystallized lattices
     for x=1:sizeMatrix
      for y=1:sizeMatrix
        for z=1:sizeMatrix
          
          if ((matrix.state(x, y, z) == 1)&&(matrix.orientation(x, y, z)!=0)) #only if the main cell is equal of 1 
        
            crystCells = crystCells+1;
          
          elseif((matrix.state(x, y, z) == 1)&& (matrix.orientation(x, y, z)==0))
            
            matrix.state(x, y, z) =0;
            
          end
          
        endfor
      endfor
     endfor
     
     #percentage recrystallized
            percCryst = crystCells/modelSize;
            printf ("%.2f%% \n", percCryst*100);

     ## printf ("\n\nRecrys cell found %d \n\nModel size %d\n\n", crystCells, modelSize);
     
     fflush(stdout);
     
     
     
     matrix = auxMatrix;
     
         

    
until(crystCells>=modelSize)


#setting back State to non-recrystallized to new processing 
     matrix.state = zeros(sizeX, sizeY, sizeZ);
     
endfunction




#randomly create first grains
function [auxMatrix] = firstGrainGrowth(matrix, auxMatrix, sizeMatrix, x, y, z)

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
              if (matrix.orientation(x,y,z) !=0)
                if (matrix.state(i,j,k) != 1) #if the neighbour cell is different of 1

                    auxMatrix.state(i, j, k) = matrix.state(x,y,z);
                    auxMatrix.orientation(i, j, k) = matrix.orientation(x,y,z);
                    auxMatrix.energy(i, j, k) = matrix.energy(x,y,z);
                    auxMatrix.count(i, j, k) = matrix.count(x,y,z);             
                    
                endif
               endif         
            endif
      
        endfor
      endfor
    endfor

  
    
endfunction