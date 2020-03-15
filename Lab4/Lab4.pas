program lab4;

uses mystrings;

var 
	s: string;
	fin,fout: textfile;
	
begin
	try
		assignfile(fin,ParamStr(1));
		reset(fin);
		assignfile(fout,ParamStr(2));
		rewrite(fout);
		
		while not eof(fin) do begin
			readln(fin,s);
			s := trim(s);
			writeln(fout,s);
			makeNewStrings(s, fout);
			writeln(fout,'========================================');
		end;	
		closefile(fin);
		closefile(fout);
	except
		on System.IndexOutOfRangeException do 
			writeln('Недостаточно параметров или выход за пределы описания массива');
		on System.IO.FileNotFoundException do writeln('Невозможно открыть файл');
	end;
end.
