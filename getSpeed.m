% Calculate the speed of the coaster given an initial and current height
function v = getSpeed(h,h0)
    v = sqrt(2*9.8*(h0-h));
end