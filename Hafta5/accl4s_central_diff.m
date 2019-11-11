function a = accl4s_central_diff(s,delta_t)
%s
%
%

for i = 3:length(s)-2
    a1(i) = (s(i+2,1)-2*s(i,1)+s(i-2,1))/(4*delta_t^2);
    a2(i) = (s(i+2,2)-2*s(i,2)+s(i-2,2))/(4*delta_t^2);
end
a = [a1', a2'];