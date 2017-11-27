function matrix = SRX(matrix, sizeMatrix)


  const = inputConst();
  modelSize = sizeMatrix^3;

  printf("\nBeginning of Simulation \n\n");
  ctime(time)
  fflush(stdout);
  tic();

  printf("Beginning Nucleation\n");
  fflush(stdout);

  [matrix, nuclei] = nucleation(matrix, sizeMatrix);      #function
  printf("\n")
  toc();
  printf("\n");
  tic();

  figure (3);
         
  header = ["Nuclei - " datestr(date,30)];
  plotMatrix (matrix.state, sizeMatrix, header);
  

  #initialize SRX
  count = 1;
  pRecrys = 0.0;

  time = const.tStep ;
  auxnRecrys = nuclei;


  printf("\nBeginning Grain Growth\n");
  fflush(stdout);

  do 

  
        printf("\nTime step: %.2f%s \n", const.tStep * count);    
        fflush(stdout);
     
   
          auxMatrix = matrix;
          
          nRecrys = 0.0;
          
          
            #it goes through each element of the matrix 
            for x=1:sizeMatrix
              for y=1:sizeMatrix
                for z=1:sizeMatrix
                  
                  if (matrix.state(x, y, z) == 0)
                      
                     #calls stored energy function
                      [aux] = storedEnergy(matrix, sizeMatrix, x, y, z); 
                      
                      auxMatrix.v(x, y, z) = aux.v(x, y, z);
                      auxMatrix.nextOrient(x, y, z) = aux.nextOrient(x, y, z);
                      
                      #printf("\n1 %f\n", auxMatrix.v(x, y, z));
                      #fflush(stdout); 

                  elseif (matrix.state(x, y, z) == 1)
   
                       #calls grain boundary curvatura function
                      [aux] = grainCurvature(matrix, sizeMatrix, x, y, z);
                      
                      auxMatrix.v(x, y, z) = aux.v(x, y, z);
                      auxMatrix.nextOrient(x, y, z) = aux.nextOrient(x, y, z);
                      
                        #printf("\n2 %f\n", matrix.v(x, y, z));
                        #fflush(stdout);
                  endif 
                  
                
                endfor
              endfor
             endfor
       
       
       
         #to verify e recrystalize 
         
          for x=1:sizeMatrix
            for y=1:sizeMatrix
              for z=1:sizeMatrix
                
                if (auxMatrix.v(x, y, z) > rand)

  
                 auxMatrix.orientation(x,y,z) = auxMatrix.nextOrient(x, y, z);
 
                 auxMatrix.state(x,y,z) = 1;
                 auxMatrix.v(x,y,z) = 0;
             
                  
                endif 
                
              
              endfor
            endfor
           endfor
           
           
           matrix = auxMatrix;

         
               
               
               #calculate and save percentage of recrystalyzed lattice over each time step
 
             for x=1:sizeMatrix
              for y=1:sizeMatrix
                for z=1:sizeMatrix
              
                  if matrix.state(x, y, z) == 1
                  
                      nRecrys = nRecrys + 1;
                 
                  endif 
                
                endfor
              endfor
             endfor
            
         
             auxpRecrys = (nRecrys/modelSize);
             
               
              if (count == 1)
               
                pRecrys = auxpRecrys;
                
                
               else
                
                 pRecrys = [pRecrys ; auxpRecrys];
                  
                 
               end
             
             printf("\nRecrystallized: %.2f%% \n", pRecrys(count)*100);
             count = count + 1;
             
             fflush(stdout);
             
             
             fileName = [ "Size - " num2str(sizeMatrix) " Temperature " num2str(const.temp) "K - SRX - " " Date - " datestr(date,22)];
             save ("-binary", fileName, "matrix");
             
             fflush(stdout);
             
             
             
             fileName = [ "Size - " num2str(sizeMatrix) " Temperature " num2str(const.temp) "K - Percentage Recrystallized and Time - " " Date - " datestr(date,22)];
             save ("-binary", fileName, "pRecrys", "time");
             
             fflush(stdout);
             
             
           
             #set and saves next time step
             time = [time; const.tStep * count];
             
            
            
   until (pRecrys(count-1)>=1)
   
   toc();
   
   
  
   
   #plotting final results
   
       matrix = grainBoundary (matrix, sizeMatrix);
       
       figure (4);
       
        header = ["Final result - " datestr(date,30) " Size - " num2str(sizeMatrix) " Temperature " num2str(const.temp) "K"];
        plotMatrix (matrix.orientation, sizeMatrix, header);
      
       figure (5);

        header = ["Grain contour final - " datestr(date,30) " Size - " num2str(sizeMatrix) " Temperature " num2str(const.temp) "K"];
        plotMatrix (matrix.boundary, sizeMatrix, header);
        
         printf("\nCalculating volume\n\n ");
   
   tic();
   #calculate volume of each grain
   
    #[matrix, grainSize] = calcVolume(matrix, sizeMatrix);
    
    #fileName = [ "Size - " num2str(sizeMatrix) " Temperature " num2str(const.temp) "K - GrainSize - " " Date - " datestr(date,22)];
    #save ("-binary", fileName, "grainSize");
    
   toc();

endfunction