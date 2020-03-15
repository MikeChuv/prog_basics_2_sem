//переписать ввод-вывод  для множеств на базе символов и логических, с учетом универсальности

unit mycharset_chars;

interface

type TCharSet = record 
                    s: array[1..255] of char;
                    n: integer;
                    end;

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
    i: integer;
begin
    for i := 1 to x.n do begin
        write(f,x.s[i]);
    end;
    writeln(f);
end;

procedure Init(var x:TCharSet);
begin
    x.n := 0;
end;


function InSet(const ch:char; const x:TCharSet):boolean;
var i:integer;
begin
    result := false;
    i := 1;
    while(i <= x.n) and not result do begin
        if x.s[i]=ch then result := true;
        i := i + 1;
    end;
end;


procedure Add(var x:TCharSet; ch: char);
begin
    if not InSet(ch, x) then begin 
        x.n := x.n + 1;
        x.s[x.n] := ch;
    end;
end;


function Union(const x1,x2:TCharSet):TCharSet; 
var i: integer;
begin
    result := x1;
    for i := 1 to x2.n do begin
        if not InSet(x2.s[i], x1) then begin 
            result.n := result.n + 1;
            result.s[result.n] := x2.s[i];
        end;
    end;
end;


function Intersection(const x1,x2: TCharSet):TCharSet;
var i:integer;
begin
    result.n := 0;
    for i := 1 to x1.n do 
        if InSet(x1.s[i], x2) then begin 
            result.n := result.n + 1;
            result.s[result.n] := x1.s[i];  
        end;
end;


function Difference(const x1,x2: TCharSet):TCharSet; 
var i:integer;
begin
    result.n := 0;
    for i := 1 to x1.n do 
        if not InSet(x1.s[i], x2) then begin 
            result.n := result.n + 1;
            result.s[result.n] := x1.s[i];  
        end;
end;


function Equal(const x1,x2: TCharSet):boolean;
var i: integer;
begin
    result := true;
    i := 1;
    while (i <= x1.n) and result do begin
        if not InSet(x1.s[i], x2) then result := false;
        i := i + 1;
    end; 
end;


function NotEqual(const x1,x2: TCharSet):boolean;
begin
    result := not Equal(x1,x2);
end;


end.