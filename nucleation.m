#nuclei will appear through a probabilistic methods
#At first, nucleation will occur only once. However, it can happen between time steps.

function [matrix, nuclei] = nucleation(matrix, sizeMatrix)

  const = inputConst();
  nuclei = 0;
  
  
  tic();
  do
  
          for x=1:sizeMatrix
            for y=1:sizeMatrix 
              for z=1:sizeMatrix
              
                           
                if (matrix.boundary(x, y, z) == 1)
                
   
                fflush(stdout);
                
                
                  #Critical amount of energy equation 13
                  Hc = ((const.epsilonc)/(const.a*const.epsilonc + const.b)) * const.gammaLAGB; 
                  
                  #Coefficient equation 12
                  Mn = const.C0*(matrix.energy(x, y, z)-Hc);
                 
                  #number of nuclei that can appear equation 11
                  N = Mn*exp(-const.Qa/(const.R*const.temp));
                  
                 
                  
                  #probability of nucleation equation 14
              
                  P = N*const.Sn*const.tStepSRX;
                  
                  
                 
                    
                     if (P>rand)
                  
                        printf("!");
                        fflush(stdout);
                        matrix.state(x, y, z) = 1;
                        nuclei = nuclei + 1;
                          
                     endif
                    
                endif
              
              endfor
            endfor
          endfor
          
  until(nuclei!=0)
  
  printf("\n%d\n", nuclei);
  fflush(stdout);
  
  toc();
 
endfunction