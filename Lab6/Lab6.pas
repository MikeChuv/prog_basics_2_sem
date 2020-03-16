//Если в одномерном массиве a из n элементов нет элементов, 
//модуль которого попадает в заданный диапазон, 
//найти сумму элементов массива, для которых выполняется условие a[i] ^ 2 > i. 

program lab6;

uses myRecursion;

const 	INDEX_EXCEPTION = 'Недостаточно параметров';
		FILE_EXCEPTION = 'Невозможно открыть файл';
		INTERVAL_OUT_OF_RANGE = 'Границы диапазона заданы неверно';

var fin,fout: textfile;
	a: vec;
	n: integer;
	intervalBegin, intervalEnd: real;
	thisSum: real;
begin
	try
		assignfile(fin,ParamStr(1));
		reset(fin);
		assignfile(fout,ParamStr(2));
		rewrite(fout);
		readln(fin, intervalBegin, intervalEnd);
		if (intervalBegin < 0) or (intervalEnd < 0) or (intervalBegin > intervalEnd) then 
			writeln(INTERVAL_OUT_OF_RANGE)
		else begin
			readVec(a,fin);
			writeVec(a,fout);
			if not areInInterval(a, 0, intervalBegin,intervalEnd) then begin
				thisSum := sum(a);
				writeln(fout,'Sum = ', thisSum);
			end
			else writeln(fout, 'Array has elements with abs in range: ', 
						intervalBegin, ' ',intervalEnd);
		end;
		

		
		closefile(fin);
		closefile(fout);
	except
	on System.IndexOutOfRangeException do writeln(INDEX_EXCEPTION);
	on System.IO.FileNotFoundException do writeln(FILE_EXCEPTION);
	end;
    
end.
