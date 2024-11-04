clear; clc;

nter=100;
% x=1;
x=0.5414;
Equa1 =4*x.^3 + 4*x.^2 - 6.96*x + 2.08;


M=(abs(4*x.^3)+abs(4*x.^2)+2.08+abs(- 6.96*x))*2;
% M=0;


    for iter =1:nter
        a=12*x.^2 + 8*x - 6.96+M;
        b= 8*x.^3 + 4*x.^2 - 2.08;
        %b=6*x.^3+3*x.^2-12;

        qq = a\b;x=qq;

        if iter < 4
        M = M/2; 
        elseif iter == 4
        M = 1;
        elseif iter >4 && iter <15
        M = M-0.1;
        elseif iter >14
        M = 0;
        end

        % if(iter >= nter-3)
        fprintf(' %10.4f %10.4f \n',...
                real(x),imag(x)); 
    
    end
% end
%d=det(A)
Equa1 =4*x.^3 + 4*x.^2 - 6.96*x + 2.08;