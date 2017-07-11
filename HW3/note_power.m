function distilled_power = note_power(power,Fs)
	c = 2^(1/12);
	C = 131;
	C_sharp = C * c^1;
	div_line = (C + C_sharp) / 2;
	dl1 = 1;

	distilled_power = zeros(61, 1);

	for i=0:59
	  dl2 = div_line * (c^i);
	  distilled_power(i+1) = max(power(round(dl1):round(dl2)));
	  dl1 = dl2;
	end

	dl2 = length(power);
	distilled_power(61) = max(power(round(dl1):round(dl2)));
end