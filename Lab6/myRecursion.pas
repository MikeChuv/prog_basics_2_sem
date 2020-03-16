unit myRecursion;

interface
type vec = array of real;
procedure readVec(var x: vec; f:textfile);
procedure writeVec(const x: vec; f:textfile);
function areInInterval(const x: vec; startIndex: integer; intervalBegin,intervalEnd:real):boolean;
function sum(const x: vec):real;


implementation

function areInInterval(const x: vec; startIndex: integer; intervalBegin,intervalEnd:real):boolean;
var stopIndex: integer;
begin
	stopIndex := High(x);
	if startIndex = stopIndex then
		result := (abs(x[startIndex]) > intervalBegin) and (abs(x[startIndex]) < intervalEnd)
	else
	begin
		result := 	(abs(x[startIndex]) > intervalBegin) and 
					(abs(x[startIndex]) < intervalEnd) or 
					areInInterval(x, startIndex + 1, intervalBegin,intervalEnd);
	end;
end;

procedure readVec(var x: vec; f:textfile);
var n:integer;
begin
	readln(f, n);
	SetLength(x,n);
	for i: integer := 0 to n-1 do begin
		read(f, x[i]);
	end;
end;


procedure writeVec(const x: vec; f:textfile);
var i: integer;
begin
 	for i := 0 to High(x) do begin
		write(f, x[i], '  ');
	end;
	writeln(f);
end;

function sum(const x: vec):real;
begin
	result := 0;
	for i:integer :=0 to High(x) do begin
		if power(x[i],2) > i then result += x[i];
	end;
end;



end.