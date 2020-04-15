unit mySort;

interface
type 	arrayElement = integer;
		myArray = array of arrayElement;
		sortFunction = procedure(var x: myArray);

  

procedure readArray(fin: textfile; var x: myArray);
procedure writeArray(fout: textfile; const x: myArray);

procedure bubbleSort(var x: myArray);
procedure bubbleSortFlag(var x: myArray);
procedure selectionSort(var x: myArray);
procedure insertionSort(var x: myArray);
procedure quickSort(var x: myArray; start, stop: integer);



implementation

procedure readArray(fin: textfile; var x: myArray);
var dim: integer;
begin
	readln(fin, dim);
	SetLength(x, dim);
	for i: integer := 0 to dim-1 do begin
		readln(fin, x[i]);
	end;
end;

procedure writeArray(fout: textfile; const x: myArray);
begin
	for i: integer := 0 to High(x) do begin
		writeln(fout, x[i], ' ');
	end;
end;


procedure bubbleSort(var x: myArray);
var tmp: arrayElement;
begin
	for i: integer := 0 to High(x) do begin
		for j: integer := 0 to High(x)-i-1 do begin
			if x[j] > x[j+1] then begin
				tmp := x[j];
				x[j] := x[j+1];
				x[j+1] := tmp;
			end;
		end;
	end;
end;

procedure bubbleSortFlag(var x: myArray);
var tmp: arrayElement;
	sorted: boolean;
begin
	sorted := false;
	while not sorted do begin
		sorted := true;
		for j: integer := 0 to High(x)-1 do begin
			if x[j] > x[j+1] then begin
				tmp := x[j];
				x[j] := x[j+1];
				x[j+1] := tmp;
				sorted := false;
			end;
		end;
	end;
end;

procedure selectionSort(var x: myArray);
var imin: integer;
	tmp: arrayElement;
begin
	for i: integer := 0 to High(x)-1 do begin
		imin := i;
		for j: integer := i+1 to High(x) do begin
			if x[j] < x[imin] then imin := j;
		end; 
		tmp := x[imin];
		x[imin] := x[i];
		x[i] := tmp;
	end;
end;

procedure insertionSort(var x: myArray);
var key: arrayElement;
	j: integer;
begin
	for i: integer := 1 to High(x) do begin
		key := x[i];
		j := i - 1;
		while (j >= 0) and (x[j] > key) do begin
			x[j+1] := x[j];
			j -= 1;
		end;
		x[j+1] := key; 
	end;
end;

procedure quickSort(var x: myArray; start, stop: integer);
var tmp, pivot: arrayElement;
	i, j: integer;
begin
	if (start - stop) = 1 then begin
		// swap
		if x[start] > x[stop] then begin
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
		while x[i] < pivot do i += 1;
		while x[j] > pivot do j -= 1;
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
	if start < j then quickSort(x, start, j);
	if stop > i then quickSort(x, i, stop);
end;

end.