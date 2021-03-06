%% system 
A_ = load('Data/apxA.mat');
B_ = load('Data/apxB.mat');
Uhat_ = load('Data/Uhat.mat');
x0_ = load('Data/x0.mat');

x0 = transpose(x0_.vect); 
A = A_.vect; 
B = transpose(B_.vect); 

Uhat = Uhat_.vect;
%C_ = zeros([2,length(Uhat)]);

C_ = zeros([1,length(Uhat)]);

tlen = idivide(length(Uhat),int32(3));
%C_(2,2*tlen:end) = 1;
%C_(1,1:2*tlen) = 1;
C_(1,end-tlen:end) = 1;

C = C_*Uhat; %y= c1 * uhat * x


%D = zeros(2,1);
D = zeros(1);

CSTR = ss(A,B,C,D);

CSTR.InputName = {'rot-speed'};
%CSTR.OutputName = {'vel', 'swstr'};

CSTR.OutputName = {'swstr'};

%CSTR.StateName = sn;

CSTR.InputGroup.MV = 1; %rot - speed
%CSTR.InputGroup.UD = 2;
CSTR.OutputGroup.MO = 1; %sum of swstr
%CSTR.OutputGroup.UO = 1;

%% MPC
old_status = mpcverbosity('off');

%The frequency at which we 
%calculated is 5sec/250 frames - 0.02
%Ts more or less than that doesnt work?

%how did the controller know?

Ts = 1e-7;

MPCobj = mpc(CSTR,Ts);

MPCobj.Model.Plant=minreal(MPCobj.Model.Plant);

MPCopts = mpcsimopt(MPCobj);
%MPCopts.PlantInitialState = x0; 

MPCobj.PredictionHorizon = 5;

MPCobj.ControlHorizon = 2;

%MPCobj.MV.Max = 100;
%MPCobj.MV.Min = 0;

MPCobj.MV.RateMin = -10;
MPCobj.MV.RateMax = 10;

%% review and execution

review(MPCobj)
T = 1e6;
%r = [0,0; 0,0];
r = 0.01;
sim(MPCobj,T,r)

