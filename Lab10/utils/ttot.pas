type 	student = record
    		group: string[8];
    		studentName: record
    				sSurname, sName, sFathername: string[30]; 
    				end;
    		birthYear: 1950..2005;
    		sex: char;
    		marks: record
    				maths, physics, compScience: 1..5;
    				end;
    		scholarship: integer;
		end;


var myrec: student;
    mytext: textfile;
    fuck: file of student;
    ch, space: char;
begin
    assignfile(mytext,'in.txt');
	reset(mytext);
	assignfile(fuck,'intyped.dat');
	rewrite(fuck);
	// читать пробелы как разделители между(перед) символьными или строковыми типами - это важно
	
	
	
	while not eof(mytext) do begin
	myrec.group := '';
	read(mytext,ch);
    while ch <> ' ' do begin
        myrec.group := myrec.group + ch;
        read(mytext,ch);
    end;	
	writeln(myrec.group);
/////////////////////////////////////////////////
	myrec.studentName.sSurname := '';
	read(mytext,ch);
    while ch <> ' ' do begin
        myrec.studentName.sSurname := myrec.studentName.sSurname + ch;
        read(mytext,ch);
    end;
    writeln(myrec.studentName.sSurname);
/////////////////////////////////////////////////////
	myrec.studentName.sName := '';
	read(mytext,ch);
    while ch <> ' ' do begin
        myrec.studentName.sName := myrec.studentName.sName + ch;
        read(mytext,ch);
    end;
    writeln(myrec.studentName.sName);
/////////////////////////////////////////////////////
	myrec.studentName.sFathername := '';
	read(mytext,ch);
    while ch <> ' ' do begin
        myrec.studentName.sFathername := myrec.studentName.sFathername + ch;
        read(mytext,ch);
    end;
    writeln(myrec.studentName.sFathername);
    
    read(mytext, myrec.birthYear);
    writeln(myrec.birthYear);
    
    read(mytext, space);
    read(mytext, myrec.sex);
    writeln(myrec.sex);
    
    read(mytext, space);
	readln(mytext, 
	        myrec.marks.maths,              // диапазон целый
	        myrec.marks.physics,            // диапазон целый
	        myrec.marks.compScience,        // диапазон целый
	        myrec.scholarship               // целый
	        );
	writeln(myrec.marks.maths);
	writeln(myrec.marks.physics); 
	writeln(myrec.marks.compScience); 
	writeln(myrec.scholarship); 
	write(fuck, myrec);
	end;
	
	
	
	
	
end.