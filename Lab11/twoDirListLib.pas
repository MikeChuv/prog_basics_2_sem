unit twoDirListLib;
	
interface

type
	TInfo = integer;
	PElem = ^TElem;

	TElem = record 
		info: TInfo;
		next, prev: PElem;
	end;

	TList = record 
		first, last: PElem;
	end;

procedure init(var list: TList);
function isEmpty(list: TList): boolean;
procedure printList(list: TList);
procedure printListReverse(list: TList);
procedure addToBegin(var list: TList; info: TInfo);
procedure addToEnd(var list: TList; info: TInfo);
procedure addAfterCurrent(var list: TList; cur: PElem; info: TInfo);
procedure addBeforeCurrent(var list: TList; cur: PElem; info: TInfo);
procedure deleteFirst(var list: TList);
procedure deleteCurrent(var list: TList; var prev, cur: PElem);
procedure deleteList(var list: TList);
procedure readList(f: TextFile; var list: TList);
procedure addByCondition(var list: TList; info: TInfo);
procedure deleteElements(var list: TList);
procedure readListByCondition(f: TextFile; var list: TList);
procedure search(list: TList; var first, last: PElem);


implementation

///- init(var list: TList)
/// Инициализация списка
procedure init(var list: TList);
begin
	list.first := nil;
	list.last  := nil;
end;


///- isEmpty(list: TList): boolean
/// Проверка пуст ли список
function isEmpty(list: TList): boolean;
begin
	result := list.first = nil;
end;


///- printList(list: TList)
/// Вывод списка на экран
procedure printList(list: TList);
var p: PElem;
begin
	p := list.first;
	while p <> nil do begin
		write(p^.info, ' ');
		p := p^.next;
	end;
	writeln;
end;

///- printListReverse(list: TList)
/// Вывод списка в обратном порядке
procedure printListReverse(list: TList);
var p: PElem;
begin
	p := list.last;
	while p <> nil do begin
		write(p^.info, ' ');
		p := p^.prev;
	end;
	writeln;
end;


///- addToBegin(var list: TList; info: TInfo)
/// Добавление элемента в начало списка
procedure addToBegin(var list: TList; info: TInfo);
var p: PElem;
begin
	new(p);
	p^.info := info;
	p^.prev := nil;
	if list.first = nil then begin
		p^.next := nil;
		list.first := p;
		list.last := p;
	end
	else begin
		p^.next := list.first;
		list.first^.prev := p;
		list.first := p;
	end;
end;


///- addToEnd(var list: TList; info: TInfo)
/// Добавление элемента в конец списка
procedure addToEnd(var list: TList; info: TInfo);
var p: PElem;
begin
	if list.first = nil then begin
		new(p);
		p^.info := info;
		p^.next := list.first;
		list.first := p;
		list.last := p;
	end
	else begin
		new(p);
		p^.info := info;
		p^.prev := list.last;
		p^.next := nil;
		list.last^.next := p;
		list.last := p;
	end;
end;

///- addAfterCurrent(var list: TList; cur: PElem; info: TInfo)
/// Добавление нового элемента после заданного элемента
procedure addAfterCurrent(var list: TList; cur: PElem; info: TInfo);
var p: PElem;
begin
	if cur = nil then exit;
	new(p);
	p^.info := info;
	if cur = list.last then begin // addToEnd();
		p^.prev := list.last;
		p^.next := nil;
		list.last^.next := p;
		list.last := p;
	end
	else begin
		cur^.next^.prev := p;
		p^.next := cur^.next;
		cur^.next := p;
		p^.prev := cur;
	end;
end;

///- addBeforeCurrent(var list: TList; cur: PElem; info: TInfo)
/// Добавление элемента до заданного 
procedure addBeforeCurrent(var list: TList; cur: PElem; info: TInfo);
var p: PElem;
begin
	if cur = nil then exit;
	new(p);
	p^.info := info;
	if cur = list.first then begin // addToBegin();
		p^.prev := nil;
		p^.next := list.first;
		list.first^.prev := p;
		list.first := p;
	end
	else begin
		cur^.prev^.next := p;
		p^.prev := cur^.prev;
		cur^.prev := p;
		p^.next := cur;
	end;
end;

///- deleteFirst(var list: TList)
/// Удаление первого элемента списка
procedure deleteFirst(var list: TList);
var p: PElem;
begin
	if list.first = nil then Exit;
	if list.first = list.last then begin
		dispose(list.first);
		list.first := nil;
		list.last := nil;
	end
	else begin
		p := list.first;
		list.first := list.first^.next;
		dispose(p);
		list.first^.prev := nil; 
	end;
end;


///- deleteCurrent(var list: TList; var prev, cur: PElem)
/// Удаление заданного элемента списка
procedure deleteCurrent(var list: TList; var prev, cur: PElem);
var p: PElem;
begin
	if cur = nil then exit;
	if (cur = list.first) and (list.first = list.last) then begin
		dispose(list.first);
		list.first := nil;
		list.last := nil;
		prev := nil;
		cur := nil;
	end
	else if cur = list.first then begin
		list.first := list.first^.next;
		list.first^.prev := nil;
		dispose(cur);
		cur := list.first;
	end
	else if cur = list.last then begin
		list.last := list.last^.prev;
		list.last^.next := nil;
		dispose(cur);
		cur := nil;
	end
	else begin
		prev^.next := cur^.next;
		cur^.next^.prev := cur^.prev;
		p := cur^.next;
		dispose(cur);
		cur := p;	
	end;
end;

///- deleteList(var list: TList)
/// Удаление списка
procedure deleteList(var list: TList);
var p: PElem;
begin
	while list.first <> nil do begin
		p:= list.first;
		list.first := list.first^.next;
		dispose(p);
	end;
	list.last := nil;
end;

///- readList(f: TextFile; var list: TList)
/// Ввод из файла
procedure readList(f: TextFile; var list: TList);
var info: TInfo;
begin
	while not eof(f) do begin
		read(f, info);
		addToEnd(list, info);
		end;
end;



///- addByCondition(var list: TList; info: TInfo)
/// Добавление элемента с сохранением порядка
procedure addByCondition(var list: TList; info: TInfo);
var p:PElem;
begin
	p := list.first;
	if p = nil then addToBegin(list, info)
	else if abs(p^.info) <= abs(info) then addToBegin(list, info)
	else begin
		while p^.next <> nil do begin
			if abs(p^.next^.info) <= abs(info) then begin
				addAfterCurrent(list, p, info);
				exit;
			end;
			p := p^.next;
		end;
		addToEnd(list, info);
	end;
end;

///- deleteElements(var list: TList)
/// Удаление из списка элементов, удовлетворяющих условию
procedure deleteElements(var list: TList);
var prev,cur: PElem;
begin
	prev := nil;
	cur := list.first;
	while cur <> nil do begin
		if (cur^.info mod 2 = 0) then deleteCurrent(list, prev, cur)
		else begin
			prev := cur;
			cur := cur^.next;
		end;
	end;
end;

///- readListByCondition(f: TextFile; var list: TList)
/// Ввод из файла с созданием порядка
procedure readListByCondition(f: TextFile; var list: TList);
var info: TInfo;
begin
	while not eof(f) do begin
		read(f, info);
		addByCondition(list, info);
	end;
end;



///- search(list: TList; var first, last: PElem)
/// Поиск элемента, удовлетворяющего условию
procedure search(list: TList; var first, last: PElem);
var p: PElem;
begin
	first := nil;
	last := nil;
	p := list.first;
	while (p <> nil) do begin
		if (p^.info mod 2 = 0) then begin
			first := p;
			break;
		end  
		else p := p^.next;
	end;
	p := list.last;
	while (p <> nil) do begin
		if (p^.info mod 2 = 0) then begin
			last := p;
			break;
		end
		else p := p^.prev;
	end;
end;

end.