//Найти максимальный элемент первой строки матрицы, содержащей более трёх элементов, неравных заданному числу. 
//Если такой строки нет, сформировать новый массив – найти номера строк матрицы, сумма элементов которых меньше 0. 

program lab5;

uses myDynamicArray;

var 	a: mas;
	b: vec;
    	fin, fout : textfile;
    	an, am, l : integer;
    	k, max: real;
begin
	try
		assignfile(fin,ParamStr(1));
		reset(fin);
		assignfile(fout,ParamStr(2));
		rewrite(fout);
		readln(fin, k);
		readMatrix(a, fin, an, am);
		writeMatrix(a, fout, an, am);
		if not findFirstMax(a, an, am, k, max) then begin
			writeln(fout, 'Max = ',max);
		end
		else begin
			makeNewArray(a,b,an,am,l);
			writeVector(b,an,l,fout);
		end;		
		closefile(fin);
		closefile(fout);
	except
		on System.IndexOutOfRangeException do writeln('Недостаточно параметров');
		on System.IO.FileNotFoundException do writeln('Невозможно открыть файл');
	end;  
end.
