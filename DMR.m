function [matrix, sizeMatrix] = DMR()

 tic();

  printf("Creating First DMR\n\n");
  ctime(time)
  fflush(stdout);

  const = inputConst();
  #calls function to create the first matrix
  [matrix, sizeMatrix] = defineMatrix;             #function
  modelSize = sizeMatrix^3;

  auxState=matrix.state;
  fileName = ["DMRstate-  Size - " num2str(sizeMatrix) " Date - " datestr(date,22)];
  save ("-binary", fileName, "");
  
  auxOrient = matrix.state;
  fileName = ["DMRorient-  Size - " num2str(sizeMatrix) " Date - " datestr(date,22)];
  save ("-binary", fileName, "auxOrient");

  #calculating energy

  printf("Calculating Energy DMR\n\n");
  fflush(stdout);

  [matrix] = calcEnergy(matrix, sizeMatrix);       #function
  
  auxEnergy = matrix.energy;
  fileName = ["DMRenergy-  Size - " num2str(sizeMatrix) " Date - " datestr(date,22)];
  save ("-binary", fileName, "auxEnergy");

  #nucleation


  matrix = grainBoundary (matrix, sizeMatrix);     #function

 
  fileName = [ "Size - " num2str(sizeMatrix) " Temperature " num2str(const.temp) "K - DMR" " Date - " datestr(date,22)];
  save ("-binary", fileName, "matrix");

  fileName = [ "Size - " num2str(sizeMatrix) " Temperature " num2str(const.temp) "K - sizeMatrix-" " Date - " datestr(date,22)];
  save ("-binary", fileName, "sizeMatrix");

  figure (1);

  header = ["DMR for simulation - " datestr(date,30) " Size - " num2str(sizeMatrix) " Temperature " num2str(const.temp) "K"];
  plotMatrix (matrix.orientation, sizeMatrix, header);
  
   figure (2);

  header = ["Grain contour DMR for simulation - " datestr(date,30) " Size - " num2str(sizeMatrix) " Temperature " num2str(const.temp) "K"];
  plotMatrix (matrix.boundary, sizeMatrix, header);

  toc();

endfunction