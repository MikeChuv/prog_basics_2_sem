 //вариант 31

//Отсортировать исходные данные по году рождения. - целое
//Найти студентов, имеющих три тройки. 
//Определить, сколько из них учится в группе А-14-18. 
//Отсортировать выходные данные по группе. - строка

program lab10;

uses myStudents;

const 	INDEX_EXCEPTION = 'Недостаточно параметров';
		FILE_EXCEPTION = 'Невозможно открыть файл';
		NO_STUDENTS = 'Нет студентов с тремя тройками';
		GROUP_NAME = 'А-14-18';
		NO_INPUT_RECORDS = 'Во входном файле нет записей';

var fout: textfile;
	fin: studentFile; 
	inArray, outArray: studentArray; // массивы записей о студентах
	numStudentsInGroup: integer;
begin
	try
		assignfile(fin,ParamStr(1));
		reset(fin);
		assignfile(fout,ParamStr(2));
		rewrite(fout, Encoding.UTF8);
		readRecordsFromTyped(fin, inArray);
		if Length(inArray) <> 0 then begin
			quickSort(inArray, 0, High(inArray), birthYearKey);
			writeln(fout,'Сортировка массива по году рождения: ');
			writeRecordsToText(inArray, fout);
			writeln(fout);
			findWithAllThree(inArray, outArray);
			if Length(outArray) <> 0 then begin
				numStudentsInGroup := inGroup(outArray, GROUP_NAME);
				writeln(fout,'Всего студентов из группы ', GROUP_NAME,': ',numStudentsInGroup);
				writeln(fout);
				quickSort(outArray, 0, High(outArray), groupKey);
				writeRecordsToText(outArray, fout);
			end
			else writeln(fout, NO_STUDENTS); // нет записей, удовлетворяющих условию
		end
		else writeln(fout, NO_INPUT_RECORDS);
		closefile(fin);
		closefile(fout);
	except
	on System.IndexOutOfRangeException do writeln(INDEX_EXCEPTION);
	on System.IO.FileNotFoundException do writeln(FILE_EXCEPTION);
	end;
    
end.
