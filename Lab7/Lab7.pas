 //вариант 32

program lab7;

uses myTypedFile;

const 	INDEX_EXCEPTION = 'Недостаточно параметров';
		FILE_EXCEPTION = 'Невозможно открыть файл';
		INTERVAL_OUT_OF_RANGE = 'Границы диапазона заданы неверно';
		IO_EXCEPTION = 'Попытка считывания за концом текстового файла. Попробуйте убрать пробел или пустую строку в конце файла';
		ARGUMENT_EXCEPTION = 'В файле нет чисел в диапазоне от -9.9 до 9.9 или положительных чисел';

var fin,fout: textfile;
	realFile: typedRealFile;
begin
	try
		assignfile(fin,ParamStr(1));
		reset(fin);
		assignfile(fout,ParamStr(2));
		rewrite(fout);
		assignfile(realFile,'inputTyped.dat');
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
	on System.ArgumentOutOfRangeException do writeln(ARGUMENT_EXCEPTION);
	end;
    
end.
