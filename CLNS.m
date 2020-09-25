%testing closed loop nominal stability 
A_ = load('Data/apxA.mat');
B_ = load('Data/apxB.mat');
Uhat_ = load('Data/Uhat.mat');
x0_ = load('Data/x0.mat');

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