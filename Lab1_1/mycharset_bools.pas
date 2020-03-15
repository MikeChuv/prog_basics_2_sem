unit mycharset_bools;

interface

type TCharSet = array [0..255] of boolean;

procedure Init(var x:TCharSet);
function InSet(const ch:char; const x:TCharSet):boolean;
procedure Add(var x:TCharSet; ch: char);
function Union(const x1,x2:TCharSet):TCharSet;
function Intersection(const x1,x2: TCharSet):TCharSet;
function Difference(const x1,x2: TCharSet):TCharSet;
function Equal(const x1,x2: TCharSet):boolean;
function NotEqual(const x1,x2: TCharSet):boolean;
procedure vvod(var x:TCharSet; f:textfile);
procedure vivod(var x:TCharSet; f:textfile);


implementation

procedure vvod(var x:TCharSet; f:textfile);
var ch:char;
begin
    while not eoln(f) do begin
        read(f,ch);
        Add(x,ch);        
    end;
    readln(f);
end;


procedure vivod(var x:TCharSet; f:textfile);
var ch:char;
    i:integer;
begin
    for i := 0 to 255 do begin
        if x[i] then write(f,chr(i));
    end;
    writeln(f);
end;

procedure Init(var x:TCharSet);
var i:integer;
begin
    for i := 0 to 255 do 
        x[i] := false;
end;


function InSet(const ch:char; const x:TCharSet):boolean;
var i:integer;
begin
    result := x[ord(ch)];
end;


procedure Add(var x:TCharSet; ch: char);
begin
    x[ord(ch)] := true;
end;


function Union(const x1,x2:TCharSet):TCharSet; 
var i: integer;
begin
    for i := 0 to 255 do
        result[i] := x1[i] or x2[i];
end;


function Intersection():TCharSet;
var i: integer;
begin
    for i := 0 to 255 do 
        result[i] := x1[i] and  x2[i];
end;


function Difference(const x1,x2: TCharSet):TCharSet; 
var i:integer;
begin
    for i := 0 to 255 do begin
        result[i] := x1[i] and not x2[i];    
    end;
end;


function Equal(const x1,x2: TCharSet):boolean;
var i: integer;
begin
    result := true;
    i := 0;
    while (i <= 255) and result do begin
        if x1[i] xor x2[i] then result := false;
        i := i + 1;
    end; 
end;


function NotEqual(const x1,x2: TCharSet):boolean;
begin
    result := not Equal(x1,x2);
end;




initialization

finalization

end.