function getRow(pos,width)
	y = 1
	r = 1:width:width*(width+1)
	for i in 1:width
		if pos >= r[i] && pos < r[i+1]
			y=i
		end
	end
	return y
end

function getCol(pos,width)
	return pos%width == 0 ? width : pos%width
end

function getMatrix(time,width,range)
	x = getCol(time,width)
	y = getRow(time,width)
	return (x*range/(width-1) - 3*range/4)  , (y*range/(width-1) - 3*range/4)
end

	
function getSpiral(time,period,amp)
	omega = omega = 2pi / period;
	v = 0.2;
	x = v.*time .* cos.(omega .* time);
	y = v.*time .* sin.(omega .* time);
	return amp*x,amp*y
end

print("RFC functions loaded")

