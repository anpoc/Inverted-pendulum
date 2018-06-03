function [M, L] = jury(P,N)

if nargin <2
    N=10;
end
P=P(1)/abs(P(1))*P;
P=sym(P);
n=length(P);
M=sym(zeros(2*n,n));
M(1,:)=P(n:-1:1);
M(2,:)=P(1:1:n);
syms epsilon
for i=1:n-1
    for j=1:n-i
        M(2*i+1,j)=det( [M(2*i-1,1) M(2*i-1,j+1);M(2*i,1) M(2*i,j+1)] )/(-M(2*i,1));
        M(2*i+2,n-i+1-j)=M(2*i+1,j);
    end
    if isempty(symvar(M(2*i+2,1))) == 1 % There is a special case only if the first element is not a variable
        if isempty(symvar(M(2*i+2,:))) == 1 % Special cases when all values are numbers
            if sum(abs(double(M(2*i+1,:)))) < 10^(-N) % Special case of a row of zeros
                disp(['Row of zeros: ' num2str(2*i+1) ',  ' num2str(2*i+2) '. Order of auxiliar polynomial: ' num2str(n-i) ]);
                for j=1:n-i
                    M(2*i+1,j)=M(2*i-1,j+1)*j; % Derivative of auxiliar polynomial
                    M(2*i+2,n-i+1-j)=M(2*i+1,j);
                end
                sig=M(2*i+1,n-i)/abs(M(2*i+1,n-i)); % Sign change of auxiliar polynomial
                M(2*i+1,:)=sig*M(2*i+1,:);
                M(2*i+2,:)=sig*M(2*i+2,:);
            elseif abs(double(M(2*i+2,1)))<10^(-N)  && sum(abs(double(M(2*i,2:n)))) > 10^(-N) % Special case when the first element of the row iz zero and the others are values
                M(2*i+2,1)=epsilon;
                M(2*i+1,n-i)=epsilon;
            end
        elseif abs(double(M(2*i+2,1)))<10^(-N) % Special case when the first element of the row iz zero and some other elements are variables
            M(2*i+2,1)=epsilon;
            M(2*i+1,n-i)=epsilon;
        end
    end
end
M=vpa(M);
M1=limit(M,epsilon,0,'right'); % RD_NINF = -inf, RD_INF = inf
M1=vpa(M1);
for i=1:n-1
    L(i,1)=M1(2*i+2,1);
end