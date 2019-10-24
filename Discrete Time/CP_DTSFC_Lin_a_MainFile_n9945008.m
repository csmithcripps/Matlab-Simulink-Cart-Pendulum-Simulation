%Clear Workspace
clearvars; close all; clc; clear

%% Init parameters
m  = 0.15;
Mc = 0.4;
l  = 0.2;
g  = 9.81;

%% Compute Linearisation Matrices
Aa = [ 0 ,       0            , 1 , 0 ;
       0 ,       0            , 0 , 1 ;
       0 ,  (-(g*m)/Mc)       , 0 , 0 ;
       0 , ((g*(Mc+m))/(l*Mc)), 0 , 0 ];
   
Ba = [0;0;1/Mc;-1/(l*Mc)];

Ca = [1,0,0,0;
      0,1,0,0];

Da = zeros(2,1);


%% Define Continuous Time SS model and Convert to Discrete
T_s = 0.03;


sysc = ss(Aa,Ba,Ca,Da);

sysdzoh = c2d(sysc,T_s,'zoh');

%% Eigenvalues
lambda = [-3,-4,-5,-6];
dLambda = zeros(4,1);
for i = 1:length(lambda)
    dLambda(i) = exp(lambda(i)*T_s);
end

Ka = place(Aa ,Ba ,lambda);
K_da = place(sysdzoh.A ,sysdzoh.B ,dLambda);


x0 = [0.2 20*pi/180 0 0]';












