unit myDynamicArray;

interface

type 
	vec = array of real;
	mas = array of vec;
procedure readMatrix(var x: mas; f:textfile; var n,m: integer);
procedure writeMatrix(const x: mas; f:textfile; const n,m: integer);
function findFirstMax(x: mas; const n,m:integer; const k: real; var max: real):boolean; // будет 
procedure makeNewArray(const x: mas; var y: vec; const n,m: integer; var l: integer);
procedure writeVector(y: vec; const n:integer;const l: integer; f:textfile);


implementation
	
function moreThanThree(v: vec; const m: integer; const k:real):boolean;
var 	j,counter: integer;
	fl: boolean;
begin
	counter := 0;
	for j := 0 to m-1 do begin
		if v[j] <> k then counter += 1;
	end;	
	if counter > 3 then result := true;
end;


function findMax(v: vec; const m: integer):real;
var 	j: integer;
begin
	result := v[0];
	for j := 1 to m-1 do begin
		if v[j] > result then result := v[j]; 
	end;	
end;


procedure readMatrix(var x: mas; f:textfile; var n,m: integer);
var i,j : integer;
begin
	readln(f,n,m);
	SetLength(x,n);
	for i := 0 to length(x)-1 do setlength(x[i],m);

	for i := 0 to n-1 do begin
		for j := 0 to m-1 do begin
			read(f, x[i,j]);
		end;
		readln(f);	
	end;	
end;

procedure writeMatrix(const x: mas; f:textfile; const n,m: integer);
var i,j:integer;
begin
	for i := 0 to n-1 do begin
		for j := 0 to m-1 do begin
			write(f, x[i,j], ' ');
		end;
		writeln(f);
	end;
end;


function findFirstMax(x: mas; const n,m:integer; const k: real; var max: real):boolean;
var 	fl : boolean;
	i:integer;

begin
	fl := true;
	i := 0;
	while (i < n) and fl do begin
		if moreThanThree(x[i],m,k) then begin
			max := findMax(x[i],m);
			fl := false;
		end;
		i += 1;
	end;
	result := fl;
end;	






procedure makeNewArray(x: mas; var y: vec; const n,m: integer; var l: integer);
var 	i,j: integer;
	sum: real;
begin
	SetLength(y,n);
	l := 0;
	for i := 0 to n-1 do begin
		sum := 0;
		for j := 0 to m-1 do begin
			sum += x[i,j];
		end;
		if sum < 0 then begin
			y[l] := i + 1;
			l += 1;
		end;	
	end;
end;	

procedure writeVector(y: vec; const n:integer;const l: integer; f:textfile);
var i: integer;
begin
	writeln(f,'Rows indexes:');
	for i := 0 to l-1 do begin
		write(f, y[i]:6:0, ' ');
	end;
	writeln(f);
end;	

end.
