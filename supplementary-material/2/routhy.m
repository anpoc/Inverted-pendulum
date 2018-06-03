function [ routh_array ] = routhy( charPoly )
%ROUTHY Function by Kenny Miltenberger 22JUL15
%   This function computes the Routh-Hurwitz 'array' according to wikipedia's 
%   wonderful explanation.  The input should be an array of coefficients of
%   the charateristic polynomial from highest power to lowest power,
%   including the x^0's coefficient.  The easiest way to get this from your
%   system is Matlab's "charpoly" function, which is what this function was
%   designed for.  This is DESIGNED TO WORK WITH SYMBOLS.
%
%   In the marginally stable case, it will introduce an epsilon so you can
%   keep trucking on calculations.  The function is also equipped to handle
%   when a whole row is zero (see wiki example)
%
%   As per the Routh-Hurwitz Criterion, the number of sign changes in the
%   first column of the array correspond to the number of roots in the open
%   right half plane.
%
%   Note: this isn't done as efficiently as possible.  Instead of
%   calculating dimensions based on patterns, I just "try-catch", and if
%   the indexing is wrong we ignore it.  It still works, but it is
%   inefficient in this way.  This function was tested on the wikipedia
%   example, a marginal example
%
%   source: https://en.wikipedia.org/wiki/Routh%E2%80%93Hurwitz_stability_criterion

%% Start with allocation
% do routh hurwitz, figure out number of entries total "n", m is there as a
% dummy
[m n] = size(charPoly);
jwRoots = 0; %roots on the JW axis
syms epsilon x; % we'll use this if we divide by zero

% flip so we can get our indexing correct, naming in line with routh hurwitz
% wiki entry
a_cof = flip(charPoly); 

% pre-allocate coefficients so we don't have an "array growing in a loop"
% note it is a symbolic matrix.  Make the dimensions an appropriate size.
if(mod(n,2)~= 0)
    dimension = (n+1)/2 + 2;
else
    dimension = n/2 + 2;
end

routh_array = zeros(n,n,'sym');
dimension = n;


%% Put in first two lines (standard)
% first row is the first half of same even/odd as the power
pi = n; % power index (wiki index)
routh_array(1,1) = a_cof(pi);
routh_array(2,1) = a_cof(pi-1);

% note instead of properly calculating the number of rows used, we're just
% ignoring indexing errors.  Sloppy but effective.
for(l = 2:1:dimension)
    % first row
    try
        routh_array(1,l) = a_cof(pi-2);
    catch err
        routh_array(1,l) = 0;
    end
    
    % second row
    try
        routh_array(2,l) = a_cof(pi-3);
    catch err
        routh_array(2,l) = 0;
    end
    pi = pi-2;
end

%%
% loop through each element, 'l' is the loop counter, 'i' reserved for
% index of the b and c elements

for(row = 3:1:dimension)
    
    % grab the two rows above the current row for calculations
    row1above = (routh_array(row-1,:));
    row2above = (routh_array(row-2,:));
    
    % for marginal case, put an epsilon if we're going to divide
    % by zero and the row isn't all zero
    if ((row1above(1) == 0) && ~(isequal(row1above,zeros(1,dimension,'sym'))) )
       routh_array(row-1,1) = epsilon; 
       row1above(1) = epsilon; 
       jwRoots = jwRoots+2;
    
    % next marginal case if the whole row is zeros, follows "Case 2"
    % http://www.vis.uky.edu/~cheung/courses/ee422g/lecture9.pdf
    elseif (isequal(row1above,zeros(1,dimension)))
            auxPoly = 0;
            jwRoots = jwRoots+2;
            power=dimension-(row-2);
            index = 1;
            newRow = zeros(1,dimension,'sym');
            
            % some funkiness with dimensions, but grabbing each coeff and
            % combining into the appropriate symbolic poly
            for i=power:-1:0
                
                %for debugging, making sure we pick up the right polynomial
                auxPoly = auxPoly + row2above(index)*x^(power-2*index+2);
                
                %now we chail rule the value and toss it into the new row
                newRow(index) = row2above(index)*(power-2*index+2);
                
                %so we continue moving across the vector
                index = index+1;
            end

            row1above = newRow;
            routh_array(row-1,:) = newRow;
    end
    
    % i corresponds to the columns, or index from wiki
    for(i = 1:1:dimension)
        
        % again instead of being clever about rows, we're just going to deal
        % with the idexing errors we get
        try
            
            routh_array(row,i) = (row1above(1)*row2above(i+1) - ...
            row2above(1)*row1above(i+1))/(row1above(1));
        
        catch err
            
            routh_array(row,i) = 0;
            
        end
    end
end

% Remove NAN's from us being sloppy
% (if the first entry starting at the bottom is NAN, we remove that row)
while(isnan(routh_array(dimension,1)))

    routh_array(dimension,:) = [];
    dimension = dimension - 1;
end

disp(cat(2,'Imaginary Roots :',num2str(jwRoots)));

end
