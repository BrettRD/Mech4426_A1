function p = plotRoots(count, x)


	h=figure(1);

	[w,a] = systemRoots(count, x)

	%page = figure('Position',[startx,starty,width,height]);

	Gstartx = floor(w(2)-1000);
	Gendx   = ceil(w(count)+1000);
	stepsize = 10;
	omega = Gstartx:stepsize:Gendx;
	receptance = abs(1./stiffness(omega, x));
	

	for index = 1:count-1
	
		fflush (stdout);
		
		sp=subplot (2, count-1, index);
		p = get(sp, 'position');
		p(1) = p(1)-0.1;
		p(3) = p(3)+0.1;
		set(sp, 'position', p);

		startx = floor((w(index+1)-900)/stepsize) - floor(Gstartx/stepsize);
		endx =    ceil((w(index+1)+900)/stepsize) - floor(Gstartx/stepsize);


		plot(omega(startx:endx), receptance(1,startx:endx), '-r','LineWidth',2, ...
			 omega(startx:endx), receptance(2,startx:endx), '-g','LineWidth',2, ...
			 omega(startx:endx), receptance(3,startx:endx), '-b','LineWidth',2 );


		title(['Mode ', int2str(index)]);
		xlabel('Frequency, (rad/s)');
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
	sp = subplot (2, count-1, [count:2*count-2]);
	p = get(sp, 'position');
	p(1) = p(1)-0.1;
	p(3) = p(3)+0.05;
	set(sp, 'position', p);
	
	plot(omega, receptance(1,:), '-r','LineWidth',2, ...
		 omega, receptance(2,:), '-g','LineWidth',2, ...
		 omega, receptance(3,:), '-b','LineWidth',2 );

	title('Full system response');
	xlabel('Omega, (rad/s)');
	ylabel('Receptance (rad/Nm)');
	axis([Gstartx, Gendx, 0, 1.1*max(receptance(1,:))]);


	%make it pretty
	FN = findall(h,'-property','FontName');
	set(FN,'FontName','/usr/share/fonts/dejavu/DejaVuSerifCondensed.ttf');
	fontsizes = findall(h,'-property','FontSize');
	set(fontsizes,'FontSize',12);

	l=legend('damped', 'undamped', 'damper');
	set(l, 'LineWidth',2, 'location', 'northeastoutside');

	print(h,'-dpng','-color','Response.png')
endfunction