function P = calculate_conformal(I, S, method)
%'     Conformal Map Transformation   ';
%'      Serdar Aritan 2009 BAG        ';
%' ---------------------------------- ';
%
%' Image Coordinates of Calibration Points : I';
%' Space Coordinates of Calibration Points : S';
 
[rS, cS] = size(S);
[rI, cI] = size(I);
% % check the matrice size
if cS ~= cI || rS ~= rI 
     error('matrix dimension');
end

% Coefficients Matrix
A =[I(:,1) -I(:,2) ones(rI,1) zeros(rI,1);
    I(:,2)  I(:,1) zeros(rI,1) ones(rI,1)];

save A.txt A -ASCII;
Stxt = S(:);
save b.txt Stxt -ASCII;
%Im1 = [I(:)]; % u(1), ... ,u(n) , v(1), ... , v(n)

% There are two type of solutions for overdetermined systems of eq.
% 1. Least Square Method [ \ ]
% 2. Psedou Inverse [ pinv() ]
if method == 1 
    P = A\S(:);
elseif method == 2
    P = pinv(A)*S(:);
else
    disp('missing method!!');
end