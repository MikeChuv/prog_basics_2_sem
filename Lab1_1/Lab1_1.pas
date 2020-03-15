program Lab1;

uses mycharset_bools;

var a,b,c,res: TCharSet;
    fin,fout: textfile; 

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
                res := Union(a,b); // объединение 
                write(fout,'Union: ');
                vivod(res,fout);
                writeln(fout);
                res := Intersection(a,b);// пересечение
                write(fout,'Intersection: ');
                vivod(res,fout);
                writeln(fout);
                res := Difference(a,b);// разность множеств
                write(fout, 'Difference: ');
                vivod(res,fout);
                writeln(fout);
                res := Difference(Union(a,b), Union(b,c));   //(а или б) искл (б или с)
                write(fout,'Expr: ');
                vivod(res,fout);
                closefile(fout);
                end;
    end;
end.