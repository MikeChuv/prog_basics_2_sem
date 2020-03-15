program lab2;

uses computing;
var 	e,xs,xi,xn: real;
	a,b,tmp: real;
	ni,ns,nn: integer;
begin
		
	writeln('Введите левый и правый конец отрезка');
	readln(a,b);
	if (a>b) or (a>1) or (b<1.7) or (a<0) or (b>2.7) then 
		writeln('Неверно заданы концы отрезка')
	else begin
		writeln('Введите точность');
		readln(e);
		if (e<=0) or (e>1) then writeln('Неверно введена точность')
		else begin
			writeln('Для функции 1:');
			writeln('Решение методом секущих: ');
			secMethod( a,b, xs, e, myfunc1, ns);
			writeln('Решение методом простых итераций: ');
			tmp := (a+b)/2;
			iterMethod( tmp, xi,e,myfunc1, ni );
			writeln('Решение методом Ньютона: ');
			newtonMethod( tmp, xn,e,myfunc1, nn );
			writeln('==================================');	
			writeln('Для функции 2:');
			writeln('Решение методом секущих: ');
			secMethod( a,b, xs, e, myfunc2, ns);
			writeln('Решение методом простых итераций: ');
			tmp := (a+b)/2;
			iterMethod( tmp, xi,e,myfunc2, ni );
			writeln('Решение методом Ньютона: ');
			newtonMethod( tmp, xn,e,myfunc2, nn );
		end;	
	end;
end.	


