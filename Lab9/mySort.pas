unit mySort;

interface

procedure directMerge(nameOfInputFile, nameOfOutputFile: string);
procedure naturalMerge(nameOfInputfile, nameOfOutputfile: string);



implementation


procedure directMerge(nameOfInputFile, nameOfOutputFile: string); 
const 
	tmpFile1 = 'tmpFile_1.txt'; 
	tmpFile2 = 'tmpFile_2.txt'; 
 
var 
	fin, fout, finTmp1, finTmp2:  TextFile; 
	series, n, value1, value2, writeOps1, writeOps2: integer; // что такое n,v и тп
	eof1, eof2: boolean; 
 

begin 
	n := 1; //
	repeat 
		// разделение
		assignfile(fin, nameOfInputFile); 
		reset(fin); 
		assignfile(finTmp1, tmpFile1); 
		rewrite(finTmp1); 
		assignfile(finTmp2, tmpFile2); 
		rewrite(finTmp2); 
	
		series := 0; 
		while true do begin 
			for i: integer := 1 to n do begin 
				read(fin, value1); 
				write(finTmp1, ' ', value1); 
				if eof(fin) then break; 
			end; 
			if eof(fin) then break; 

			for i: integer := 1 to n do begin 
				read(fin, value2); 
				write(finTmp2, ' ', value2); 
				if eof(fin) then break; 
			end; 
			if eof(fin) then break; 

			{ Подсчитываем количество полных серий в каждом из файлов } 
			series += 1; 
		end; 

		closefile(fin); 
		closefile(finTmp1); 
		closefile(finTmp2); 
	
		{ Слияние } 
		assignfile(finTmp1, tmpFile1); 
		reset(finTmp1); 
		assignfile(finTmp2, tmpFile2); 
		reset(finTmp2); 
		assignfile(fout, nameOfOutputFile); 
		rewrite(fout); 

		// начальные значения
		eof1 := false; 
		eof2 := false; 
		read(finTmp1, value1); 
		read(finTmp2, value2); 
		for i: integer := 1 to series do begin 
			writeOps1 := 0; 
			writeOps2 := 0; 
			while (writeOps1 < n) and (writeOps2 < n) do begin 
				if value1 < value2 then begin 
					write(fout, ' ', value1); 
					writeOps1 += 1; 
					if eof(finTmp1) then begin eof1 := true; break; end; 
					read(finTmp1, value1); 
				end 
				else begin 
					write(fout, ' ', value2);  
					writeOps2 += 1; 
					if eof(finTmp2) then begin eof2 := true; break; end; 
					read(finTmp2, value2); 
				end; 
			end; 

			// дописываем незавершённые серии
			while writeOps1 < n do begin 
				write(fout, ' ', value1); 
				writeOps1 += 1; 
				if eof(finTmp1) then begin eof1 := true; break; end; 
				read(finTmp1, value1); 
			end; 
			while writeOps2 < n do begin 
				write(fout, ' ' ,value2); 
				writeOps2 += 1; 
				if eof(finTmp2) then begin eof2 := true; break; end; 
				read(finTmp2, value2); 
			end; 
		end; 

		// дописываем неполные серии  
		while not eof1 and not eof2 do begin
			if value1 < value2 then begin 
				write(fout, ' ', value1); 
				if eof(finTmp1) then begin eof1 := true; break; end; 
				read(finTmp1, value1); 
			end 
			else begin 
				write(fout, ' ', value2); 
				if eof(finTmp2) then begin eof2 := true; break; end; 
				read(finTmp2, value2); 
			end; 
		end;
		// выводим хвост в файл
		while not eof1 do begin 
			write(fout, ' ', value1); 
			if eof(finTmp1) then begin eof1 := true; break; end; 
			read(finTmp1, value1); 
		end; 
		while not eof2 do begin 
			write(fout, ' ', value2); 
			if eof(finTmp2) then begin eof2 := true; break; end; 
			read(finTmp2, value2); 
		end; 
	
		closefile(finTmp1); 
		closefile(finTmp2); 
		closefile(fout); 
		
		n := n * 2; 
		
		nameOfInputFile := nameOfOutputFile; 
	until series = 0; 
	

	deleteFile(tmpFile1); 
	deleteFile(tmpFile2); 
end; 




procedure naturalMerge(nameOfInputfile, nameOfOutputfile: string);
const 
	tmpFile1 = 'tmpFile_1.txt'; 
	tmpFile2 = 'tmpFile_2.txt'; 
  
var
	currentValue, nextValue, series, newCurrentValue, newNextValue : integer;
	fin, fout, finTmp1, finTmp2 : text;
	eof1, eof2, endOfSeries1, endOfSeries2, ordered: boolean;
  
begin
	series := 4;
	while series > 2 do begin
		assign(fin, nameOfInputfile);
		reset(fin);
		assign(finTmp1, tmpFile1);
		rewrite(finTmp1);
		assign(finTmp2, tmpFile2);
		rewrite(finTmp2);

		
		
		series := 1;
		read(fin, currentValue);

		ordered := true;
		while not eof(fin) do begin
			if ordered then write(finTmp1, ' ', currentValue)
			else 			write(finTmp2, ' ', currentValue);
			read(fin, nextValue);
			if nextValue < currentValue then begin 
				ordered := not ordered;
				series += 1;
			end;
			currentValue := nextValue; 
		end;

		if ordered then 	write(finTmp1, ' ', currentValue)
		else				write(finTmp2, ' ', currentValue);

		close(fin);
		close(finTmp1);
		close(finTmp2);

		// слияние
		assign(finTmp1, tmpFile1);
		reset(finTmp1);
		assign(finTmp2, tmpFile2);
		reset(finTmp2);
		assign(fout, nameOfOutputfile);
		rewrite(fout);
		// начальные значения
		eof1:= false;
		eof2:= false;
		if series = 1 then eof2:= true;
		read(finTmp1, currentValue);
		if series <> 1 then read(finTmp2, nextValue);

		while not eof1 and not eof2 do begin
			endOfSeries1 := false;
			endOfSeries2 := false;
			while not endOfSeries1 and not endOfSeries2 do
				if currentValue < nextValue then begin
					write(fout, ' ', currentValue);
					// завершаем серию, если конец файла 1
					if eof(finTmp1) then begin
						eof1:= true;
						endOfSeries1:= true;
						break;
					end;
					read(finTmp1, newCurrentValue);
					// или если встречаем неупорядоченность
					if newCurrentValue < currentValue then endOfSeries1:= true;
					currentValue:= newCurrentValue;
				end
				else begin
					write(fout, ' ', nextValue);
					// завершаем серию, если конец файла 2
					if eof(finTmp2) then begin 
						eof2:= true;
						endOfSeries2:= true;
						break;
					end;
					read(finTmp2, newNextValue);
					// или если встречаем неупорядоченность
					if newNextValue < nextValue then endOfSeries2:= true; 
					nextValue:= newNextValue;
				end;
			
			
			// дописываем неполные серии
				while not endOfSeries1 do begin
					write(fout, ' ', currentValue);
					// завершаем серию, если конец файла 1
					if eof(finTmp1) then begin
						endOfSeries1:= true;
						eof1 := true;
						break;
					end;
					read(finTmp1, newCurrentValue);
					// или если встречаем неупорядоченность
					if newCurrentValue < currentValue then endOfSeries1 := true;
					currentValue:= newCurrentValue;
				end;
				
				
				while not endOfSeries2 do begin
					write(fout, ' ', nextValue);
					// завершаем серию, если конец файла 2
					if eof(finTmp2) then begin
						endOfSeries2:= true;
						eof2 := true;
						break; 
					end;
					read(finTmp2, newNextValue);
					// или если встречаем неупорядоченность
					if newNextValue < nextValue then endOfSeries2 := true;
					nextValue:= newNextValue;
				end;
			end;

			// выводим хвост в файл
			while not eof1 do begin
				write(fout, ' ', currentValue);
				if eof(finTmp1) then begin eof1 := true; break; end;
				read(finTmp1, currentValue);
			end; 
			while not eof2 do begin
				write(fout, ' ', nextValue);
				if eof(finTmp2) then begin eof2 := true; break; end;
				read(finTmp2, nextValue);
			end;
		


		close(fout);
		close(finTmp1);
		close(finTmp2);
		nameOfInputfile:= nameOfOutputfile;

		end;
	{ Удаляем промежуточные файлы } 
	DeleteFile(tmpFile1); 
	DeleteFile(tmpFile2);
end;





end.