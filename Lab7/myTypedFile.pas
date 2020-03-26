unit myTypedFile;

interface
type typedRealFile = file of real;
procedure textIntoTyped(ftext: textfile; ftyped: typedRealFile);
procedure printTypedFIle(ftyped:typedRealFile; fout:textfile);
procedure insertLastPositive(ftyped:typedRealFile);

implementation

procedure textIntoTyped(ftext: textfile; ftyped: typedRealFile);
var num: real;
begin
	rewrite(ftyped);
	while not eof(ftext) do begin
		read(ftext, num);
		if (num > -9.9) and (num < 9.9) then
			write(ftyped, num);
	end;
	closefile(ftyped);
end;

procedure printTypedFIle(ftyped:typedRealFile; fout:textfile);
var num: real;
begin
	reset(ftyped);
	while not eof(ftyped) do begin
		read(ftyped, num);
		write(fout,num:4:2, ' ');
	end;
	closefile(ftyped);
end;

function lastPositivePosition(ftyped:typedRealFile):integer;
var num: real;
begin
	reset(ftyped);
	while not eof(ftyped) do begin
		read(ftyped, num);
		if num > 0 then begin
			result := filepos(ftyped);
		end;
	end;
	closefile(ftyped);
end;

procedure insertLastPositive(ftyped:typedRealFile);
var position: integer;
	num,lastPositive : real;
begin
	position := lastPositivePosition(ftyped)-1;
	reset(ftyped);
	seek(ftyped, position);
	read(ftyped,lastPositive);
	for i:integer := position-1 downto 0 do begin
		seek(ftyped, i);
		read(ftyped,num);
		seek(ftyped, i+1);
		write(ftyped,num);
	end;
	seek(ftyped, 0);
	write(ftyped,lastPositive);
	closefile(ftyped);
end;

end.