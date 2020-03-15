unit mysetarray;


interface

type
	myset = set of char;
	SetsArray = array[1..100000] of myset;
	hashArray = array[1..100000] of integer;
	func = function(s:myset):integer;

procedure readMySetArray(var x:SetsArray;var n: integer; f:textfile);
procedure writeMySetArray(var x:SetsArray;const n: integer; f:textfile);

function Hash1(s:myset):integer;
function Hash2(s:myset):integer;
function Hash3(s:myset):integer;


procedure findCollsEquals (const csets: SetsArray;const n: integer; var colls,equals: integer; f:func );


implementation
{===========================================================}
{===========================================================}
function f1( var x,y,z: byte ):byte ;
begin
	result := (x and y) or (not x and z);
end;
{===========================================================}
{===========================================================}
function f2( var x,y,z: byte ):byte ;
begin
	result := (x and z) or (not z and y);
end;
{===========================================================}
{===========================================================}
procedure readMySetArray(var x:SetsArray;var n: integer; f:textfile);
var 	ch:char;
	i: integer;
begin
	i := 1;
	while not eof(f) do begin
		while not eoln(f) do begin
			read(f,ch);
			include(x[i],ch);
		end;
		readln(f);
		i += 1;
	end;
	n := i - 1;
	
end;

{===========================================================}
{===========================================================}
procedure writeMySetArray(var x:SetsArray;const n: integer; f:textfile);
var 	ch:char;
	i: integer;
begin
	for i := 1 to n do begin
		for ch:= chr(0) to chr(255) do begin
			if ch in x[i] then write(f,ch);
		end;
		writeln(f);
	end;
end;
{===========================================================}
{===========================================================}
function Hash1(s:myset):integer; // set of char
var 
	ch:char;
	i:integer;
begin
	result := 0;//empty;
	i := 1;
	foreach ch in s do
	begin
		result := result - (ord(ch) shl i);
		i := i + 1;
	end;
end;
{===========================================================}
{===========================================================}
function Hash2(s:myset):integer; // set of char
var
	ch:char;
	one:integer;

begin
	one := 1;
	result := 0; //empty;
	foreach ch in s do	
		result := result or (one shl (ord(ch)-ord('A')));
end;
{===========================================================}
{===========================================================}
function Hash3(s:myset):integer;
var
	a,b,c,d:byte;
	ch: char;
begin
	a := $01234567;
	b := $89ABCDEF;
	c := $FEDCBA98;
	d := $76543210;
	foreach ch in s do begin
		a := a + f1(b,c,d) + ord(ch);
		a := (a shl 1) or (a shr 7);
		b := b + f2(a,c,d) + ord(ch);
		b := (b shl 3) or (b shr 5);
	end;
	result := a;
	result := (result shl 8) or b;
	result := (result shl 8) or c;
	result := (result shl 8) or d;
end;
{===========================================================}
{===========================================================}
procedure findCollsEquals( const csets: SetsArray;const n: integer; var colls,equals: integer; f:func );
var 	fl: boolean;
	    ch: char;
      thisHashArray: hashArray;
begin
	colls := 0;
	equals := 0;
	for i:integer := 1 to n do thisHashArray[i] := f(csets[i]);
	for i:integer := 1 to n-1 do begin
		for j:integer := i+1 to n do begin
			if thisHashArray[i] = thisHashArray[j] then begin
        
				colls := colls + 1;
				fl := true;
				foreach ch in csets[i] do begin
					if not(ch in csets[j]) then begin
						fl := false;
						break;
					end;	
				end;
				if fl then begin
					equals := equals + 1;
					colls := colls - 1;
				end;
			end;
		end;		
	end;
	
end;
{===========================================================}
{===========================================================}

initialization

finalization
end.
