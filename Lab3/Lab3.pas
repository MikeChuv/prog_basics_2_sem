program lab3;
uses mysetarray;


var
	csets: SetsArray;
	thisset: myset;
	n, equals, colls: integer;
	fin,fout: textfile;
	errorIndexMsg, errorFileMsg: string;

begin

	errorIndexMsg := 'Недостаточно параметров или выход за предел описания массива';
	errorFileMsg := 'Невозможно открыть файл для чтения';
	try
		assignfile(fin,ParamStr(1));
		reset(fin);
		assignfile(fout, ParamStr(2));
		rewrite(fout);
		readMySetArray(csets,n,fin);
		writeln(fout, 'Number of sets = ',n);
		writeln(fout,'==================================================');
		writeln(fout);
		colls := 0;
	  	equals := 0;
		findCollsEquals(csets,n,colls,equals,Hash1);
		findEqualsColls(csets,n,colls,equals,Hash1);
//		for i:integer := 1 to n do begin
//      writeln(fout,Hash1(csets[i]));
//    end;
		writeln(fout,'colls = ', colls );
		writeln(fout,'equals = ', equals);
		writeln(fout,'==================================================');
		writeln(fout);
		colls := 0;
	  equals := 0;
		findCollsEquals(csets,n,colls,equals,Hash2);
//		for i:integer := 1 to n do begin
//      writeln(fout,Hash2(csets[i]));
//    end;
		writeln(fout,'colls = ', colls );
		writeln(fout,'equals = ', equals);
		writeln(fout,'==================================================');
		writeln(fout);
		colls := 0;
	  equals := 0;
		findCollsEquals(csets,n,colls,equals,Hash3);	
//		for i:integer := 1 to n do begin
//      writeln(fout,Hash3(csets[i]));
//    end;
		writeln(fout,'colls = ', colls );
		writeln(fout,'equals = ', equals);

		closefile(fin);
		closefile(fout);
	except
		on System.IndexOutOfRangeException do writeln(errorIndexMsg);
		on System.IO.FileNotFoundException do writeln(errorFileMsg);
		
	end;
	
end.

