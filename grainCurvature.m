#recrystallization driven by grain curvature

function [matrix] = grainCurvature(matrix, sizeMatrix, x, y, z)

   const = inputConst();
   ci=0;
   orientation(const.numOrien)=0;
   

   for i=x-2:x+2
        for j=y-2:y+2
          for k=z-2:z+2
            
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
                  
                if(matrix.state(i, j, k)==1)
                
                  if(matrix.orientation(i,j,k)==matrix.orientation(x,y,z))
                    ci = ci+1;
                  else
                    aux = matrix.orientation(i,j,k);
                    
                    if(aux!=0)
                      orientation(aux) = orientation(aux) + 1;
                    endif
                  end
                 
                endif
                  
             endfor
        endfor
      endfor              
                      
        #grain growth due to net pressure can occur only at the grain boundary of a pair 
        #of recrystallized grains
        
       
        
        #calculate grain boundary curvature driven force
        #M = power((const.d0*const.bB*const.bB)/(const.k*const.temp),(-1*const.Qb/(const.R*const.temp)));
        #kappa = (const.A/const.cs) * ((const.Kink-ci)/(const.Nline));
        #P = kappa * const.gammaHAGB;
        
        matrix.v(x, y, z) = matrix.v(x, y, z) + (const.M*(const.Kink-ci));
        
        
        [numberLattice, auxOrien ] = max(orientation);
        if(numberLattice > 0)
          matrix.nextOrient(x,y,z) = auxOrien;
        endif
        
        #attention
        #{
        if(matrix.v(x,y,z) >=1)
          [numberLattice, auxOrien ] = max(orientation);
          matrix.orientation(x,y,z) = auxOrien;
          matrix.state(x, y, z) = 1;
        endif
        #}              
      


endfunction