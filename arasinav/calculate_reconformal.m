function H = calculate_reconformal(P, I)
%'     Conformal Map Transformation   ';
%'      Serdar Aritan 2009 BAG        ';
%' ---------------------------------- ';
%' Image Coordinates of Data Points : I';
%' Conformal Coefficients           : P';

[rI, cI] = size(I);
 
% Coefficients Matrix
A =[I(:,1) -I(:,2) ones(rI,1) zeros(rI,1);
    I(:,2)  I(:,1) zeros(rI,1) ones(rI,1)];

disp(A);

H = A*P;
H = [H(1:length(H)/2) H((length(H)/2)+1:end)];
