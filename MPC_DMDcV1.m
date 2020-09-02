%% system 
A_ = load('apxA.mat');
B_ = load('apxB.mat');
Uhat_ = load('Uhat.mat');
x0_ = load('x0.mat');

x0 = transpose(x0_.vect); 
A = A_.vect; 
B = transpose(B_.vect); 

Uhat = Uhat_.vect;
C_ = zeros([2,length(Uhat)]);

tlen = idivide(length(Uhat),int32(3));
C_(2,2*tlen:end) = 1;
C_(1,1:2*tlen) = 1;

C = C_*Uhat; 


D = zeros(2,1);

CSTR = ss(A,B,C,D);

CSTR.InputName = {'rot-speed'};
CSTR.OutputName = {'vel', 'swstr'};
%CSTR.StateName = sn;

CSTR.InputGroup.MV = 1;
%CSTR.InputGroup.UD = 2;
CSTR.OutputGroup.MO = 2;
CSTR.OutputGroup.UO = 1;

%% MPC
old_status = mpcverbosity('off');

%The frequency at which we 
%calculated is 5sec/250 frames - 0.02
%Ts more or less than that doesnt work?

%how did the controller know?

Ts = 0.011;

MPCobj = mpc(CSTR,Ts);

MPCobj.Model.Plant=minreal(MPCobj.Model.Plant);

MPCopts = mpcsimopt(MPCobj);
MPCopts.PlantInitialState = x0; 

MPCobj.PredictionHorizon = 10;


MPCobj.MV.Max = 100;
MPCobj.MV.Min = -100;

MPCobj.MV.RateMin = -1;
MPCobj.MV.RateMax = 1;

%% review and execution

review(MPCobj)
T = 251;
r = [0,0; 0,0];
sim(MPCobj,T,r)

