 //вариант 32

program lab7;

uses myTypedFile;

const 	INDEX_EXCEPTION = 'Недостаточно параметров';
		FILE_EXCEPTION = 'Невозможно открыть файл';
		INTERVAL_OUT_OF_RANGE = 'Границы диапазона заданы неверно';
		IO_EXCEPTION = 'Попытка считывания за концом текстового файла. Попробуйте убрать пробел или пустую строку в конце файла';

var fin,fout: textfile;
	n: integer;
	realFile: typedRealFile;
begin
	try
		assignfile(fin,ParamStr(1));
		reset(fin);
		assignfile(fout,ParamStr(2));
		rewrite(fout);
		assignfile(realFile,'inputTyped.pas');
		textIntoTyped(fin,realFile);
		printTypedFIle(realFile, fout);
		insertLastPositive(realFile);
		writeln(fout);
		writeln(fout,'====================');
		printTypedFIle(realFile, fout);

		
		closefile(fin);
		closefile(fout);
	except
	on System.IndexOutOfRangeException do writeln(INDEX_EXCEPTION);
	on System.IO.FileNotFoundException do writeln(FILE_EXCEPTION);
	on System.IO.IOException do writeln(IO_EXCEPTION);
	end;
    
end.
