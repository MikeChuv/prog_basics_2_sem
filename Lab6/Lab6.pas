program lab6;

uses myRecursion;

var fin,fout: textfile;
	a: vec;
	n: integer;

begin
	try
		assignfile(fin,ParamStr(1));
		reset(fin);
		assignfile(fout,ParamStr(2));
		rewrite(fout);
		readVec(a,fin);
		writeVec(a,fout);
		

	except
	on System.IndexOutOfRangeException do writeln('Недостаточно параметров');
	on System.IO.FileNotFoundException do writeln('Невозможно открыть файл');
	end;
    
end.
