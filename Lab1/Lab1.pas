program Lab1;

type myset = set of char;

var a,b,c,res: myset;
    fin,fout: textfile;
    ch:char;

procedure vvod(var x:myset; f:textfile);
begin
    while not eoln(f) do begin
        read(f,ch);
        Include(x,ch);
    end;
    readln(f);
end;

procedure vivod(var x:myset; f:textfile);
var ch:char;
begin
    for ch:= chr(0) to chr(255) do begin
        if ch in x then write(f,ch);
    end;
    writeln(f);
end;



begin
    if ParamCount < 2 then writeln('Недостаточно параметров!')
    else begin
        if not FileExists(ParamStr(1)) then	      { Проверяем существование файла }
            writeln('Невозможно открыть файл ''', ParamStr(1), ''' для чтения')
            else begin
                AssignFile(fin, ParamStr(1));
                Reset(fin);
                vvod(a,fin);
                vvod(b,fin);
                vvod(c,fin);
                closefile(fin);
                AssignFile(fout, ParamStr(2));
                Rewrite(fout);
                res := a + b; // объединение 
                write(fout,'Union: ');
                vivod(res,fout);
                writeln(fout);
                res := a * b; // пересечение
                write(fout,'Intersection: ');
                vivod(res,fout);
                writeln(fout);
                res := a - b;// разность множеств
                write(fout,'Difference: ');
                vivod(res,fout);
                writeln(fout);
                res := (a+b)-(b+c); //(а или б) искл (б или с)
                write(fout, 'Expr: ');
                vivod(res,fout);
                closefile(fout);
                end;
        end;
end.