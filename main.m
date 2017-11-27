printf("Grain growth simulation\n\n")

t=cputime;
 
  [matrix, sizeMatrix] = DMR();

  matrix = SRX(matrix, sizeMatrix);
  
     
printf('Total cpu time: %f seconds\n', cputime-t);
 