program Lab8;

uses mySort;

const 	INDEX_EXCEPTION = 'Недостаточно параметров';
		FILE_EXCEPTION = 'Невозможно открыть файл';
		IO_EXCEPTION = 'Попытка считывания за концом текстового файла. Попробуйте убрать пробел или пустую строку в конце файла';

var fin,fout,logfile: textfile;
	thisArray: myArray;
	start, finish: System.DateTime;
	ts: System.TimeSpan;
	foutName : string;
	testFileArray : array[1..12] of string := (
		'ForwardIntegers1000.txt',
		'ForwardIntegers5000.txt',
		'ForwardIntegers10000.txt',
		'ForwardIntegers20000.txt',
		'BackwardIntegers1000.txt',
		'BackwardIntegers5000.txt',
		'BackwardIntegers10000.txt',
		'BackwardIntegers20000.txt',
		'RandomIntegers1000.txt',
		'RandomIntegers5000.txt',
		'RandomIntegers10000.txt',
		'RandomIntegers20000.txt'
	);
	sortAlgArray : array[1..5] of string := (
		'bubbleSort',
		'bubbleSortFlag',
		'selectionSort',
		'insertionSort',
		'quickSort'
	);

begin
	try
		assignfile(logfile,'sort.log');
		rewrite(logfile);
		for i: integer := 1 to 5 do begin
			for j: integer := 1 to 12 do begin
				assignfile(fin,testFileArray[j]);
				reset(fin);
				readArray(fin, thisArray);
				closefile(fin);
				foutName := 'SortedFiles\' + sortAlgArray[i] + ' '+ testFileArray[j];
				assignfile(fout,foutName);
				rewrite(fout);
				start := System.DateTime.Now;
				case i of
					1 : bubbleSort(thisArray);
					2 : bubbleSortFlag(thisArray);
					3 : selectionSort(thisArray);
					4 : insertionSort(thisArray);
					5 : quickSort(thisArray, 0, High(thisArray));
				end;
				finish := System.DateTime.Now;
				ts := finish - start;
				//writeln(logfile, sortAlgArray[i] , ' ', testFileArray[j]);
				writeln(logfile,Format('{0:d2}.{1:d3}', ts.Seconds, ts.Milliseconds));
				//writeln(logfile);
				writeArray(fout, thisArray);
				closefile(fout);
			end;
			writeln(logfile,'####################################################');	
		end;
		closefile(logfile);
	except
	on System.IndexOutOfRangeException do writeln(INDEX_EXCEPTION);
	on System.IO.FileNotFoundException do writeln(FILE_EXCEPTION);
	on System.IO.IOException do writeln(IO_EXCEPTION);
	end;
    
end.