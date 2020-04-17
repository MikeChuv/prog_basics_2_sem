program Lab8;

uses mySort;

const 	INDEX_EXCEPTION = 'Недостаточно параметров';
		FILE_EXCEPTION = 'Невозможно открыть файл';
		IO_EXCEPTION = 'Попытка считывания за концом текстового файла. Попробуйте убрать пробел или пустую строку в конце файла';

var logfile: textfile;
	start, finish: System.DateTime;
	ts: System.TimeSpan;
	inputFileName,outputFileName: string;
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
	sortAlgArray : array[1..2] of string := (
		'directMerge',
		'naturalMerge'
	);

begin
	try
		assignfile(logfile,'sort.log');
		rewrite(logfile);

		for i: integer := 1 to 2 do begin
			for j: integer := 1 to 12 do begin
				inputFileName := 'FilesToSort\' + testFileArray[j];
				outputFileName := 'SortedFiles\' + sortAlgArray[i] + ' '+ testFileArray[j];
				start := System.DateTime.Now;
				case i of
					1 : directMerge(inputFileName, outputFileName);
					2 : naturalMerge(inputFileName, outputFileName);
				end;
				finish := System.DateTime.Now;
				ts := finish - start;
				writeln(logfile, sortAlgArray[i] , ' ', testFileArray[j]);
				writeln(logfile,Format('{0:d2}.{1:d3}', ts.Seconds, ts.Milliseconds));
				writeln(logfile);
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