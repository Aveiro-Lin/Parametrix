clc; clear     %% x  y  z  t  X  Y  Z  T  A  B 0

%x=-22; y=-7; z=3.5; t=11; 

x=1; y=-2; z=3; t=24; 
%1,3+，2,4-  -anchor 

% x=1; y=-2; z=3; t=23; 
%1,3+，2,4-  -anchor 


% x=-3; y=7; z=5; t=-9; 

% x=2; y=4; z=-9; t=3; 
X=1/x; Y=1/y; Z=1/z; T=1/t; A=x/t; B=y/z;  
a(10,10)=0; nter=1000; c1=exp(-0.1*y*t) 

X=1/x; Y=1/y; Z=1/z; T=1/t; A=x/t; B=y/z;   

% M1=(abs(22/x) + abs(7/y) + abs(y) + abs(3.5/z) + abs(11/t) + 7)*2;
% M2=(abs(0.1*(x^4+ exp(x/t) + exp(y/z))) + abs(-1.6*t^4) )*2;
% M3=(abs(x*y) + abs(- 4*z*t) + abs(y^5) + abs(32*z^5))*2;
% M4=(abs(x*z) + abs(y*t) + abs(y*y) + abs(2*y*x/t)+ abs(exp(0.1*y*t))+77+abs(c1))*2;
M1=(abs(22/x) + abs(7/y) + abs(y) + abs(3.5/z) + abs(11/t) + 7)*2;
M2=-(abs(0.1*(x^4+ exp(x/t) + exp(y/z))) + abs(-1.6*t^4) )*2;
M3=(abs(x*y) + abs(- 4*z*t) + abs(y^5) + abs(32*z^5))*2;
M4=-(abs(x*z) + abs(y*t) + abs(y*y) + abs(2*y*x/t)+ abs(exp(0.1*y*t))+77+abs(c1))*2;
% M1 = 0; M2 = 0; M3 = 0; M4 = 0;

for iter =1:nter; H=exp(-0.1*y*t);
    a(1,1)=M1; a(1,2)=1; a(1,5)=22; a(1,6)=7; a(1,7)=3.5; a(1,8)=11; 
    a(2,1)=0.4*x^3; a(2,2)=M2; a(2,4)=-6.4*t^3; a(2,9)=0.1*exp(A); a(2,10)=-0.1*exp(B);                                                 
    a(3,1)=y; a(3,2)=x+5*y^4; a(3,3)=160*z^4-4*t+M3; a(3,4)=-4*z;                                                
    a(4,1)=z; a(4,2)=2*y+t+2*A-0.1*H*t; a(4,3)=x; a(4,4)=y-0.1*H*y+M4; a(4,9)=2*y;  
    a(5,1)=X; a(5,5)=x; b5=x*X+1; a(6,2)=Y; a(6,6)=y; b6=y*Y+1; 
    a(7,3)=Z; a(7,7)=z; b7=z*Z+1; a(8,4)=T; a(8,8)=t; b8=t*T+1; 
    a(9,1)=1;  a(9,4)=-A;  a(9,9)=-t; b9=-t*A; a(10,2)=1; a(10,3)=-B; a(10,10)=-Z; b10=-Z*B;  
    b1=-7; b2=0.3*x^4-4.8*t^4-0.1*exp(A)*(1-A)+0.1*exp(B)*(1-B); b3=4*y^5+128*z^5+x*y-4*z*t; 
    b4=x*z+y*t+y*y+2*A*y+(c1-77)-H*(1+0.2*y*t); 
    b=[b1; b2; b3; b4; b5; b6; b7; b8; b9; b10]; 
    qq = a\b; x=qq(1); y=qq(2); z=qq(3); t=qq(4); X=1/x; Y=1/y; Z=1/z; T=1/t; A=x/t; B=y/z; 
    % 

    if iter < 11
    M1 = M1/2; M2 = M2/2; M3 = M3/2;M4 = M4/2;
    elseif iter == 11
    M1 = 1;M2 = 1;M3 = 1;M4 = 1;
    elseif iter >11 && iter <22
    M1 = M1-0.1; M2 = M2-0.1; M3 = M3-0.1; M4 = M4-0.1;
    elseif  iter >21
    M1 = 0; M2 = 0; M3 = 0; M4 = 0;
    end

    if(iter >= nter-3); fprintf('%10.4f %10.4f %10.4f %10.4f %10.4f %10.4f %10.4f %10.4f \n',...
    real(x),imag(x),real(y),imag(y),real(z),imag(z),real(t),imag(t)); end
end 
res1 = 22/x + 7/y + y + 3.5/z + 11/t + 7; res2 = 0.1*(x^4+ exp(x/t) - exp(y/z))-1.6*t^4;
res3 = x*y - 4*z*t + y^5 + 32*z^5; res4 = x*z + y*t + y*y + 2*y*x/t+exp(-0.1*y*t)+77-c1;  
rr = [abs(res1) abs(res2) abs(res3) abs(res4)]


%Sample RR

%  -22.0000    -0.0000    -7.0000     0.0000     3.5000    -0.0000    11.0000     0.0000
%-1643.8858    -0.0000    -7.4634    -0.0000     2.4509    -0.0000  -821.9429    -0.0000   
%   -0.5933    -0.0000   -42.5977    -0.0000    21.2989     0.0000     0.1513    -0.0000      
%    0.3234    -0.0000   -45.0327    -0.0000    22.5163     0.0000    -0.3668    -0.0000 
%    0.8899     0.0000   -47.2686     0.0000    23.6343     0.0000     0.7075     0.0000     
%   15.5354     0.0000    -9.8317     0.0000     4.9191    -0.0000     7.7679     0.0000 
%  293.4783     0.0000    -7.0000    -0.0000     3.5000    -0.0000  -146.7391    -0.0000    
%  -89.6691     0.0000    -6.5315    -0.0000     3.1994    -0.0000   -44.8346    -0.0000  
%  -89.6691     0.0000    -6.5315    -0.0000     3.1994    -0.0000   -44.8346    -0.0000 
%  -10.7129     0.0000    -7.0000     0.0000     3.5000     0.0000     5.3565     0.0000 
%    4.6010     0.0000   -16.5441     0.0000     8.2722     0.0000     8.2722     0.0000
%  -16.1965     0.0000    -7.0000     0.0000     3.5000     0.0000     8.0982     0.0000
%    0.4761     0.0000   -14.0599     0.0000     7.0300     0.0000    -0.2810     0.0000 
%   -2.0073     0.0000    14.0696     0.0000    -7.0347     0.0000    -1.0881     0.0000
%.......................................................................................

