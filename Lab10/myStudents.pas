unit myStudents;

interface
type 	student = record
			group: string[7];
			studentName: record
					sName, sSurname, sFathername: string[30]; 
					end;
			birthYear: 1950..2005;
			sex: char;
			marks: record
					math, physics, compScience: 1..5;
					end;
			scholarship: integer;
		end;
		studentArray = array of student;
		studentFile = file of student;
		compareFunc = function(stud1, stud2: student):boolean;


procedure readRecordsFromTyped(fin: studentFile;var inputArray: studentArray);
procedure findWithAllThree(inArray: studentArray; var outArray: studentArray);
function inGroup(outArray: studentArray; groupName: string[7]): integer;
procedure writeRecordsToText(outArray: studentArray; fout: textfile);
function birthYearKey(stud1, stud2: student):boolean;
function groupKey(stud1, stud2: student):boolean;
procedure quickSort(var x: studentArray; start, stop: integer; isGreater:comparefunc);

implementation

procedure readRecordsFromTyped(fin: studentFile;var inputArray: studentArray);
var i: integer;
begin
	i := 0;
	while not eof(fin) do begin
		SetLength(inputArray, i+1);
		read(fin, inputArray[i]);
		i += 1;
	end;
end;

procedure findWithAllThree(inArray: studentArray; var outArray: studentArray);
var outSize: integer;
begin
	outSize := 0;
	for i:integer := 0 to High(inArray) do begin
		if 	(inArray[i].marks.math = 3) and
			(inArray[i].marks.physics = 3) and
			(inArray[i].marks.compScience = 3) then 
			begin
				SetLength(outArray, outSize + 1);
				outArray[outSize] := inArray[i];
				outSize += 1;
			end;
	end;
end;

function inGroup(outArray: studentArray; groupName: string[7]): integer;
begin
	result := 0;
	for i:integer := 0 to High(outArray) do begin
		if outArray[i].group = groupName then result += 1;
	end;
end;

procedure writeRecordsToText(outArray: studentArray; fout: textfile);
begin
	for i:integer := 0 to High(outArray) do begin
		write(fout, outArray[i].group, ' ');
		write(fout, outArray[i].studentName.sName, ' ');
		write(fout, outArray[i].studentName.sSurname, ' ');
		write(fout, outArray[i].studentName.sFathername, ' ');
		write(fout, outArray[i].birthYear, ' ');
		write(fout, outArray[i].sex, ' ');
		write(fout, outArray[i].marks.math, ' ');
		write(fout, outArray[i].marks.physics, ' ');
		write(fout, outArray[i].marks.compScience, ' ');
		writeln(fout, outArray[i].scholarship);
	end;
end;

// сравнение целых
function birthYearKey(stud1, stud2: student):boolean;
begin
	result := stud1.birthYear > stud2.birthYear;
end;


// сравнение строк
function groupKey(stud1, stud2: student):boolean;
begin
	result := stud1.group > stud2.group;
end;

procedure quickSort(var x: studentArray; start, stop: integer; isGreater:comparefunc);
var tmp, pivot: student;
	i, j: integer;
begin
	if (start - stop) = 1 then begin
		// swap
		if isGreater(x[start], x[stop]) then begin // сравнение
			tmp := x[start];
			x[start] := x[stop];
			x[stop] := tmp;
		end;
		exit;
	end;
	// partition
	pivot := x[(start + stop) div 2];
	i := start;
	j := stop;
	repeat 
		while isGreater(pivot, x[i]) do i += 1; // сравнение
		while isGreater(x[j], pivot) do j -= 1; // сравнение
		if i < j then begin
			// swap
			tmp := x[i];
			x[i] := x[j];
			x[j] := tmp;
			i += 1;
			j -= 1;
		end
		else if i = j then begin
			i += 1;
			j -= 1;
		end;
	until i > j;
	if start < j then quickSort(x, start, j, isGreater);
	if stop > i then quickSort(x, i, stop, isGreater);
end;

end.