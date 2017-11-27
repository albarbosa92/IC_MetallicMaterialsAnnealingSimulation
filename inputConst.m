function const = inputConst()

  #input values for the simulation
  const.cs = 1E-6;

  const.size = 50;
  const.time = 1;
  const.nuclei = 10;
  const.temp = 1000;           #Temperature	T [K]
  const.tStep = 0.1;
  const.tStepSRX = 0.1;       #Length of time for recrystallization simulation steps in [seconds]
  const.tStepPostSRX = 0.1;   #Length of time for POST recrystallization simulation steps in [seconds]
  const.numOrien = 180;             #number of possible orientations
  
  const.R = 8.31;             #Universal Gas Constant	R [J/mol.K]	8.31
  const.Sn = (const.size*const.cs)^3;               #Volume nucleus can appear	Sn	1


  #material constants
  const.Qa = 160000;          #Activation Energy for Nucleation	Qa [J/mol]
  const.Qb = 140000;          #Activation energy for grain boundary motion	Qb [J/mol]
  const.J = 1.41235e11;       #Energy between two lattice sites [J/m³] - [150kJ/mol]
  
  

  const.epsilonc = 0.4;         #Critical Deformation	εc	1
  const.a = 0.000000001;        #?????a	1
  const.b = 0.00000009;         #?????b	1
  const.gammaLAGB = 0.2;        #Low angle grain boundary energy	γ lagb [J/m²]	0.2
  #const.Hi = 1;                #Amount of Energy in the cell	Hi	1
  const.C0 = 10000000000/12.2;          #Scaling Parameter	C0	1
  
  const.d0 = 0.0000011;         #Difusion Constant	D0	0.0000011
  const.bB = 2.48E-10;          #Burger's Vector	bB [m]	2.48E-10
  const.k = 1.38064852E-23;     #Boltzmann's constant	k	1

  const.G = (8.1*(10^10))*(1-0.91*((const.temp-300)/1810));
  
  const.rho = 8.8E14;              #Dislocation density	ρ	1 [[m^-2]]
  
  #Values for the grain boundary	
 
  const.gammaHAGB = 0.56;       #High angle grain boundary energy	γhagb [J/m²]	0.56
  const.A	= 1.28;       #Fitting Parameter	
  const.cs = 1E-6;         #cellular automata cell size	(μm)
  const.Kink = 75;      #Cells which create flat grain boundary	
  const.ci = 1;         #cells belongins to the ith cell
  const.Nline = 125;    #Number of cells belonging to the long range Moore's neighborhood
  
  

  
  ##
  M = ((const.d0*const.bB*const.bB)/(const.k*const.temp))*(e^(-1*const.Qb/(const.R*const.temp)));
                
  P =0.5*const.G*const.bB*const.bB*const.rho;
  
  const.V = M*P;
  const.V = const.V*const.tStep/const.cs;

  ##
  const.M = ((const.d0*const.bB*const.bB)/(const.k*const.temp))*(e^(-1*const.Qb/(const.R*const.temp)))*(const.A/const.cs)* (const.gammaHAGB)/(const.Nline);
  const.M = const.M*const.tStep/const.cs;
  
endfunction