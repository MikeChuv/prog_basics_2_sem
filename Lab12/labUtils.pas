unit labUtils;


interface

uses myStack, myQueue, myDeque;

procedure readStack(var thisStack: TStack; fin: textfile);
procedure printStack(var thisStack: TStack);
procedure readQueue(var thisQueue: TQueue; fin: textfile);
procedure printQueue(var thisQueue: TQueue);
procedure readDeque(var thisDeque: TDeque; fin: textfile);
procedure printDeque(var thisDeque: TDeque);
procedure printDequeReverse(var thisDeque: TDeque);
procedure deleteElemsByConditionFromStack(var thisStack: TStack);
procedure deleteElemsByConditionFromQueue(var thisQueue: TQueue);
procedure deleteElemsByConditionFromDeque(var thisDeque: TDeque);

implementation
///- readStack(var thisStack: TStack; fin: textfile)
/// Чтение из файла в стек
procedure readStack(var thisStack: TStack; fin: textfile);
var info: TInfo;
begin
	while not eof(fin) do begin
		read(fin, info);
		if ((info >= -50) and (info <= 50)) then push(thisStack, info);
	end;
end;

///- printStack(var thisStack: TStack)
/// Вывод содержимого стека на экран
procedure printStack(var thisStack: TStack);
var 	info: TInfo;
		tmpStack: TStack;
begin
	init(tmpStack);
	while not isEmpty(thisStack) do begin
		info := pop(thisStack);
		write(info, ' ');
		push(tmpStack, info);
	end;
	writeln;
	while not isEmpty(tmpStack) do begin
		info := pop(tmpStack);
		push(thisStack, info);
	end;
end;

///- readQueue(var thisQueue: TQueue; fin: textfile)
/// Чтение из файла в очередь
procedure readQueue(var thisQueue: TQueue; fin: textfile);
var info: TInfo;
begin
	while not eof(fin) do begin
		read(fin, info);
		if ((info >= -50) and (info <= 50)) then add(thisQueue, info);
	end;
end;

///- printQueue(var thisQueue: TQueue)
/// Вывод содержимого очереди на экран
procedure printQueue(var thisQueue: TQueue);
var 	info: TInfo;
		tmpQueue: TQueue;
begin
	init(tmpQueue);
	while not isEmpty(thisQueue) do begin
		info := get(thisQueue);
		write(info, ' ');
		add(tmpQueue, info);
	end;
	writeln;
	while not isEmpty(tmpQueue) do begin
		info := get(tmpQueue);
		add(thisQueue, info);
	end;	
end;

///- readDeque(var thisDeque: TDeque; fin: textfile)
/// Чтение из файла в дек (добавление поочередно в начало и конец дека)
procedure readDeque(var thisDeque: TDeque; fin: textfile);
var info: TInfo;
begin
	while not eof(fin) do begin
		read(fin, info);
		if ((info >= -50) and (info <= 50)) then addToBegin(thisDeque, info);
		if not eof(fin) then begin
			read(fin, info);
			if ((info >= -50) and (info <= 50)) then addToEnd(thisDeque, info);
		end;
	end;	
end;

///- printDeque(var thisDeque: TDeque)
/// Вывод содержимого дека на экран
procedure printDeque(var thisDeque: TDeque);
var 	info: TInfo;
		tmpDeque: TDeque;
begin
	init(tmpDeque);
	while not isEmpty(thisDeque) do begin
		info := getFromBegin(thisDeque);
		write(info, ' ');
		addToEnd(tmpDeque, info);
	end;
	writeln;
	while not isEmpty(tmpDeque) do begin
		info := getFromBegin(tmpDeque);
		addToEnd(thisDeque, info);
	end;	
end;

///- printDequeReverse(var thisDeque: TDeque)
/// Вывод содержимого дека на экран в обратном порядке
procedure printDequeReverse(var thisDeque: TDeque);
var 	info: TInfo;
		tmpDeque: TDeque;
begin
	init(tmpDeque);
	while not isEmpty(thisDeque) do begin
		info := getFromEnd(thisDeque);
		write(info, ' ');
		addToBegin(tmpDeque, info);
	end;
	writeln;
	while not isEmpty(tmpDeque) do begin
		info := getFromEnd(tmpDeque);
		addToBegin(thisDeque, info);
	end;	
end;

///- deleteElemsByConditionFromStack(var thisStack: TStack)
/// Удаление элементов, удовлетворяющих условию из стека 
procedure deleteElemsByConditionFromStack(var thisStack: TStack);
var 	info: TInfo;
		tmpStack: TStack;
begin
	init(tmpStack);
	while not isEmpty(thisStack) do begin
		info := pop(thisStack);
		if (info mod 2 <> 0) then push(tmpStack, info);
	end;
	while not isEmpty(tmpStack) do begin
		info := pop(tmpStack);
		push(thisStack, info);
	end;	
end;

///- deleteElemsByConditionFromQueue(var thisQueue: TQueue)
/// Удаление элементов, удовлетворяющих условию из очереди
procedure deleteElemsByConditionFromQueue(var thisQueue: TQueue);
var 	info: TInfo;
		tmpQueue: TQueue;
begin
	init(tmpQueue);
	while not isEmpty(thisQueue) do begin
		info := get(thisQueue);
		if (info mod 2 <> 0) then add(tmpQueue, info);
	end;
	while not isEmpty(tmpQueue) do begin
		info := get(tmpQueue);
		add(thisQueue, info);
	end;
end;


///- deleteElemsByConditionFromDeque(var thisDeque: TDeque)
/// Удаление элементов, удовлетворяющих условию из дека (если они при этом находятся на одинаковом расстоянии от краёв дека)
procedure deleteElemsByConditionFromDeque(var thisDeque: TDeque);
var 	infoHead, infoTail: TInfo;
		tmpDequeHead, tmpDequeTail: TDeque;
begin
	init(tmpDequeHead);
	init(tmpDequeTail);
	while not isEmpty(thisDeque) do begin
		infoHead := getFromBegin(thisDeque);
		if not isEmpty(thisDeque) then begin
			infoTail := getFromEnd(thisDeque);
			if (infoHead mod 2 <> 0) or (infoTail mod 2 <> 0) then begin
				addToEnd(tmpDequeHead, infoHead);
				addToBegin(tmpDequeTail, infoTail);
			end;	
		end
		else begin
			// if (infoHead mod 2 <> 0) then addToEnd(tmpDequeHead, infoHead); // центральный же находится на одинаковом расстоянии от краев дека? :) или только парные надо?
			addToEnd(tmpDequeHead, infoHead);
		end;
	end;
	while not isEmpty(tmpDequeHead) do begin
		infoHead := getFromEnd(tmpDequeHead);
		addToBegin(thisDeque, infoHead);
	end;
	while not isEmpty(tmpDequeTail) do begin
		infoTail := getFromBegin(tmpDequeTail);
		addToEnd(thisDeque, infoTail);
	end;
end;



end.
