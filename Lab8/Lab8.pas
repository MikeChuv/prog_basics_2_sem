program Lab8;

uses mySort;

const 	INDEX_EXCEPTION = 'Недостаточно параметров';
		FILE_EXCEPTION = 'Невозможно открыть файл';
		IO_EXCEPTION = 'Попытка считывания за концом текстового файла. Попробуйте убрать пробел или пустую строку в конце файла';

var fin,fout: textfile;
	thisArray: myArray;
	start, finish: System.DateTime;
	ts: System.TimeSpan;
	millis: integer;	
begin
	try
		// работа с файлами
		assignfile(fin,ParamStr(1));
		reset(fin);
		assignfile(fout,ParamStr(2));
		rewrite(fout);
		// читаем массив
		readArray(fin, thisArray);
		// сортировка

		start := System.DateTime.Now;
		bubbleSort(thisArray);
		//bubbleSortFlag(thisArray);
		//selectionSort(thisArray);
		//insertionSort(thisArray);
		//quickSort(thisArray, 0, High(thisArray));
		finish := System.DateTime.Now;
		ts := finish - start;
  		writeln(Format('{0:d2}:{1:d2}.{2:d3}', ts.Minutes, ts.Seconds, ts.Milliseconds));


		// вывод массива 
		writeArray(fout, thisArray);

		
		closefile(fin);
		closefile(fout);
	except
	on System.IndexOutOfRangeException do writeln(INDEX_EXCEPTION);
	on System.IO.FileNotFoundException do writeln(FILE_EXCEPTION);
	on System.IO.IOException do writeln(IO_EXCEPTION);
	end;
    
end.