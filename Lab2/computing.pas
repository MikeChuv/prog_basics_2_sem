unit computing;


interface
type 
	func = function(const x:real):real;


function myfunc1(const x:real):real;

function myfunc2(const x:real):real;
	
procedure secMethod(var x1,x2,x:real; const e: real; f:func; var n:integer);

procedure iterMethod(var x0,x:real; const e: real; f:func; var n:integer);
	
procedure newtonMethod( var x0,x:real; const e:real; f:func; var n:integer );
	
implementation
{=================================================================================}
{=================================================================================}

function myfunc1(const x:real):real;
begin
	result := sqrt( 1.96 - (power(x,3)/9) + 1/x ) - x;
end;


{=================================================================================}
{=================================================================================}

function myfunc2(const x:real):real;
begin
	result := (power(4,1/3) - power(sin(x/10),2))/(sqrt(x)) -x;
end;

{=================================================================================}
{=================================================================================}
procedure secMethod(var x1,x2,x:real; const e: real; f:func; var n:integer);
begin
	n := 1;
	repeat
		x := x2 - ( f(x2)*(x2-x1) )/( f(x2)-f(x1) );
		x1 := x2;
		x2 := x;
	until (abs(x2-x1)<e) or (n > 1000);	
	if n>1000 then writeln('Превышено количество итераций') 
	else writeln('Количество итераций: ',n);
	writeln('Значение функции: ', f(x));
	writeln('Корень: ',x);
end;		

{=================================================================================}
{=================================================================================}
procedure iterMethod(var x0,x:real; const e: real; f:func; var n:integer);
begin
	n := 1;
	repeat
		x := x0;
		x0 := f(x) + x;
		n := n + 1;
	until (abs(x-x0)<e) or (n > 1000);
	if n>1000 then writeln('Превышено количество итераций') 
	else writeln('Количество итераций: ',n);
	writeln('Значение функции: ', f(x));
	writeln('Корень: ',x);
end;	
{=================================================================================}
{=================================================================================}
procedure newtonMethod( var x0,x:real; const e:real; f:func; var n:integer );
begin
	n := 1;
	repeat
		x := x0;
		x0 := x - f(x)/( ( f(x+e/2) - f(x-e/2) ) / ( e ) );
		n := n + 1;
	until (abs(x-x0)<e) or (n > 1000);
	if n>1000 then writeln('Превышено количество итераций') 
	else writeln('Количество итераций: ',n);
	writeln('Значение функции: ', f(x));
	writeln('Корень: ',x);
end;	



initialization
finalization
end.	
