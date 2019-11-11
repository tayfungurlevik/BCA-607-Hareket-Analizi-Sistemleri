function a = accl4v_central_diff(v,delta_t)
%s
%
%

for i = 2:length(v)-1
    a1(i) = (v(i+1,1)-v(i-1,1))/(2*delta_t);
    a2(i) = (v(i+1,2)-v(i-1,2))/(2*delta_t);
end
a = [a1', a2'];