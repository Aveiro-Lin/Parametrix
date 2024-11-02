
clear; clc;
nter = 600; N=10; 
xb=3; yb=-3;
% (3,-1)

M1=(abs(xb*xb)+abs(-6*xb)+8+abs(-yb))*2;
M2=((xb-3)^2+(yb+2.1)^2+1)*2;
% M1 = 0;M2 = 0;

for iter =1:nter
 a=[2*xb-6+M1  -1; 2*xb-6  2*yb+4+M2];  
 b=[xb*xb-8; -12+xb*xb+yb*yb]; 
    qq = a\b; xb=qq(1); yb=qq(2); 

    % 
    if iter < 11
    M1 = M1/2; 
    M2 = M2/2; 
    elseif iter == 11
    M1 = 1;M2 = 1;
    elseif iter >11 && iter <22
    M1 = M1-0.1; M2 = M2-0.1;
    end

   fprintf('%9.4f %9.4f %9.4f %9.4f \n', real(xb), imag(xb), real(yb), imag(yb))
end
% end
Equa1 = xb*xb-6*xb+8-yb;
Equa2 = (xb-3)^2+(yb+2)^2-1;

