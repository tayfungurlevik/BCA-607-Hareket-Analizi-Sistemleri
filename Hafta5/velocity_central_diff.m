function h = velocity_central_diff(s,delta_t)
%s
%
%
for i = 2:length(s)-1
    h1(i) = (s(i+1,1)-s(i-1,1))/(2*delta_t);
    h2(i) = (s(i+1,2)-s(i-1,2))/(2*delta_t);
end
h = [h1', h2'];