clear; clc;

% Coefficient definition, function must pass point (10,10)
c1 = 2; c2 = 3; c3 = 4; c5 = 8; c6 = 13;
c0 = -(c1*10 + c2*10^11 + c3*10^3 + c5*exp(c6/10)+100);
d1 = 6; d2 = 7; d3 = 8; d5 = 9; d6 = 12;
d0=-(d1*10 + d2*10^11 + d3*10^3 + d5*exp(d6/10)-100);
a = zeros(4,4); 

%x=2; y=-5;
%small f
% x=3; y=1;

% x=0.4788+i; y=0.5339;


% -anchor
x=-12; y=-4;


nter=1000; % iteration times
z = 1/x; % z is the inverse of x
t = 1/y; % t is the inverse of y

% M1=(abs(c0) + abs(c1*x) + abs(c2*x^5*y^6) + abs(c3*x^3) + abs(c5*exp(c6*t)+abs(z*t)))*2;
% M2=(abs(d0) + abs(d1*y) + abs(d2*y^4*x^7) + abs(d3*y^3) + abs(d5*exp(d6*z)+abs(-z*t)))*2;
M1=-(abs(c0) + abs(c1*x) + abs(c2*x^5*y^6) + abs(c3*x^3) + abs(c5*exp(c6*t)+abs(z*t)))*2;
M2=-(abs(d0) + abs(d1*y) + abs(d2*y^4*x^7) + abs(d3*y^3) + abs(d5*exp(d6*z)+abs(-z*t)))*2;
% M1 = 0;
% M2 = 0;


    for iter = 1:nter

        a(1,1)=c1 + 5*c2*x^4*y^6 + 3*c3*x^2+M1;
        a(1,2)=6*c2*x^5*y^5;
        a(1,3)=t;
        a(1,4)=c5*c6*exp(c6*t)+z;
        a(2,1)=7*d2*x^6*y^4;
        a(2,2)=d1 + 4*d2*x^7*y^3 + 3*d3*y^2+M2;
        a(2,3)=d5*d6*exp(d6*z)-t; a(2,4)=-z;
        a(3,1)=z;
        a(3,3)=x;
        a(4,2)=t;
        a(4,4)=y;
        b1= -c0 + 10*c2*x^5*y^6 + 2*c3*x^3 + c5*c6*t*exp(c6*t) - c5*exp(c6*t)+z*t;
        b2= -d0 + 10*d2*x^7*y^4 + 2*d3*y^3 + d5*d6*z*exp(d6*z) - d5*exp(d6*z)-z*t;
        b3=x*z+1;
        b4=y*t+1;

        b=[b1; b2; b3; b4;]; 
        % Solving linear equations
        qq = a\b; 
        % update x, y, z, t
        x = qq(1); y = qq(2); z = 1/x; t = 1/y;

         % Print the result of the last iteration
            if iter < 11
            M1 = M1/10; 
            M2 = M2/10; 
            elseif iter == 11
            M1 = 1;
            M2 = 1;
            elseif iter >11 && iter <22
            M1 = M1-0.1; 
            M2 = M2-0.1;  
            elseif  iter >21
            M1 = 0; M2 = 0;
            end



                % if(iter >= nter); 
        fprintf('%10.4f %10.4f %10.4f %10.4f %10.4f %10.4f %10.4f %10.4f \n', real(x), imag(x), real(y), imag(y), real(z), imag(z), real(t), imag(t));
    %end

    end





% Calculate the value of the final equation
Equa1= c0 + c1*x + c2*x^5*y^6 + c3*x^3 + c5*exp(c6*t)+z*t;
Equa2= d0 + d1*y + d2*y^4*x^7 + d3*y^3 + d5*exp(d6*z)-z*t;
Equa3=x*z-1; Equa4=t*y-1; 
rr = [abs(Equa1) abs(Equa2) abs(Equa3) abs(Equa4)];


