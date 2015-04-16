function p = plotRoots(count, x)

	[w,a] = systemRoots(count, x)

	%page = figure('Position',[startx,starty,width,height]);

	Gstartx = floor(w(2)-1000);
	Gendx   = ceil(w(count)+1000);
	stepsize = 0.1
	omega = Gstartx:stepsize:Gendx;
	receptance = abs(1./stiffness(omega, x));
	
	for index = 1:count-1
	
		fflush (stdout);
		
		subplot (2, count-1, index);

		startx = floor((w(index+1)-1000)/stepsize) - floor(Gstartx/stepsize);
		endx =    ceil((w(index+1)+1000)/stepsize) - floor(Gstartx/stepsize);


		plot(omega(startx:endx), receptance(1,startx:endx), '-r', ...
			 omega(startx:endx), receptance(2,startx:endx), '-g', ...
			 omega(startx:endx), receptance(3,startx:endx), '-b');


		title(['Mode ', int2str(index)]);
		xlabel('Omega, (rad/s)');
		ylabel('Receptance (rad/Nm)');
		%axis([startx, endx, 0, 1.1*max(receptance(1,startx:endx))]);
		
		%plot(omega, receptance(1,:), '-r', ...
		%	 omega, receptance(2,:), '-g', ...
		%	 omega, receptance(3,:), '-b');
		axis([omega(startx), omega(endx), 0, 2*max(receptance(1,startx:endx))]);


		%fplot (@sin, [-10, 10]);
		%subplot (2, count-1, count+index-1);
		%fplot (@cos, [-10, 10]);
		%plot(omega, abs(stiffness(omega, x)));
	
	endfor
	%full plot
	subplot (2, count-1, [count:2*count-2]);
	%subplot (2, count-1, count);
	title('Full system response');
	xlabel('Omega, (rad/s)');
	ylabel('Receptance (rad/Nm)');
	plot(omega, receptance(1,:), '-r', ...
		 omega, receptance(2,:), '-g', ...
		 omega, receptance(3,:), '-b');
	axis([Gstartx, Gendx, 0, 1.1*max(receptance(1,:))]);

endfunction