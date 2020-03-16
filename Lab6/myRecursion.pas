unit myRecursion;

interface
type vec = array of real;
procedure readVec(var x: vec; f:textfile);
procedure writeVec(const x: vec; f:textfile);

implementation

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
		write(x[i], '  ');
		writeln(f, 'suck my dick');
		write(f, x[i], '  ');
	end;
	writeln(f);
end;


end.