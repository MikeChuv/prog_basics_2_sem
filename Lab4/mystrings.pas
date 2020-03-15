unit mystrings;

interface

procedure makeNewStrings( var s: string; f:textfile );

implementation
{==================================================}
{==================================================}
procedure makeNewStrings( var s: string; f:textfile );
var 	firstSpace, lastSpace: integer;
	sF,sL,newS : string;
begin
	s := trim(s);
	firstSpace := pos(' ', s);
	lastSpace := length(s);
	if lastSpace <> 0 then
		while (s[lastSpace]<>' ') and (lastSpace > 1) do begin
			lastSpace -= 1;
		end;
	if (firstSpace <> 0) and (firstSpace <> lastSpace) then begin
		
		sF := copy(s, 1, firstSpace);
		sL := copy(s, lastSpace, length(s));
		sF := trim(sF);
		sL := trim(sL);
		newS := sF + ' ' + sL;
		// newS := sF + sL;
		writeln(f,newS);
		s := copy(s, firstSpace, lastSpace - firstSpace);
		s := trim(s);
		if length(s) <> 0 then makeNewStrings(s,f);
	end
	else begin
		//if firstSpace = lastSpace then delete(s,firstSpace,1);
		writeln(f,s); 
	end;		
end;

end.
