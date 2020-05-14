unit myDeque;



interface
type 	
		/// TInfo - базовый тип структуры
		TInfo = integer;
		TDeque = record
			deque: array of TInfo;
			size, count, first, last: integer;
		end;

procedure init(var thisDeque: TDeque); overload;
function isEmpty(thisDeque: TDeque): boolean; overload;
function getFromBegin(var thisDeque: TDeque): TInfo;
function getFromEnd(var thisDeque: TDeque): TInfo;
procedure addToBegin(var thisDeque: TDeque; info: TInfo);
procedure addToEnd(var thisDeque: TDeque; info: TInfo);


implementation
const block = 10;
///- init(var thisDeque: TDeque)
/// Инициализация и очистка дека
procedure init(var thisDeque: TDeque); overload;
begin
	thisDeque.size := block;
	setLength(thisDeque.deque, thisDeque.size);
	thisDeque.count := 0;
	thisDeque.first := 0;
	thisDeque.last := 0;
end;

///- isEmpty(thisDeque: TDeque)
/// Проверка: пуст ли дек
function isEmpty(thisDeque: TDeque): boolean; overload;
begin
	result := thisDeque.count = 0;
end;

///- getFromBegin(var thisDeque: TDeque)
/// Получение (и удаление) элемента из начала дека
function getFromBegin(var thisDeque: TDeque): TInfo;
begin
	if thisDeque.count = 0 then exit;
	result := thisDeque.deque[thisDeque.first];
	thisDeque.count -= 1;
	thisDeque.first += 1;
	if thisDeque.first = thisDeque.size then thisDeque.first := 0;
end;

///- getFromEnd(var thisDeque: TDeque)
/// Получение (и удаление) элемента из конца дека
function getFromEnd(var thisDeque: TDeque): TInfo;
begin
	if thisDeque.count = 0 then exit;
	if thisDeque.last = 0 then thisDeque.last := thisDeque.size;
	result := thisDeque.deque[thisDeque.last - 1];
	thisDeque.count -= 1;
	thisDeque.last -= 1;
end;

///- addToEnd(var thisDeque: TDeque; info: TInfo)
/// Добавление нового элемента в конец дека
procedure addToEnd(var thisDeque: TDeque; info: TInfo);
var blocksToAdd: integer;
begin
	if thisDeque.count = thisDeque.size then begin
		blocksToAdd := thisDeque.first div block + 1;
		setLength(thisDeque.deque, thisDeque.size + blocksToAdd * block);
		for i: integer := 0 to thisDeque.first - 1 do
			thisDeque.deque[i + thisDeque.size] := thisDeque.deque[i];
		thisDeque.last += thisDeque.size;
		thisDeque.size += (blocksToAdd * block);
	end;
	thisDeque.deque[thisDeque.last] := info;
	thisDeque.last += 1;
	if thisDeque.last = thisDeque.size then thisDeque.last := 0;
	thisDeque.count += 1;
end;


///- addToBegin(var thisDeque: TDeque; info: TInfo)
/// Добавление нового элемента в начало дека
procedure addToBegin(var thisDeque: TDeque; info: TInfo);
var blocksToAdd: integer;
begin

	if thisDeque.count = thisDeque.size then begin
		blocksToAdd := thisDeque.first div block + 1;
		setLength(thisDeque.deque, thisDeque.size + blocksToAdd * block);
		if thisDeque.first <> 0 then begin
			for i: integer := 0 to thisDeque.first - 1 do
				thisDeque.deque[i + thisDeque.size] := thisDeque.deque[i];
		end;
		thisDeque.last += thisDeque.size;
		thisDeque.size += (blocksToAdd * block);
	end;

	// можно ли сделать это изящнее, чтобы не приходилось при каждом addToBegin переписывать весь массив?
	if thisDeque.first <> 0 then thisDeque.first -= 1
	else begin
		for i: integer := thisDeque.last downto 1 do
			thisDeque.deque[i] := thisDeque.deque[i-1];
		thisDeque.last += 1;  
	end;
	thisDeque.deque[thisDeque.first] := info;
	if thisDeque.last = thisDeque.size then thisDeque.last := 0;
	thisDeque.count += 1;

end;

end.