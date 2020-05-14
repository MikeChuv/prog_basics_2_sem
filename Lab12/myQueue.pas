unit myQueue;



interface
type 	
		/// TInfo - базовый тип структуры
		TInfo = integer;
		TQueue = record
			queue: array of TInfo;
			size, count, first, last: integer;
		end;

procedure init(var thisQueue: TQueue); overload;
function isEmpty(thisQueue: TQueue): boolean; overload;
function get(var thisQueue: TQueue): TInfo;
procedure add(var thisQueue: TQueue; info: TInfo);

implementation
const block = 10;
///- init(var thisQueue: TQueue)
/// Инициализация и очистка очереди
procedure init(var thisQueue: TQueue); overload;
begin
	thisQueue.size := block;
	setLength(thisQueue.queue, thisQueue.size);
	thisQueue.count := 0;
	thisQueue.first := 0;
	thisQueue.last := 0;
end;

///- isEmpty(thisQueue: TQueue)
/// Проверка: пуста ли очередь
function isEmpty(thisQueue: TQueue): boolean; overload;
begin
	result := thisQueue.count = 0;
end;

///- get(var thisQueue: TQueue)
/// Получение (и удаление) элемента из очереди
function get(var thisQueue: TQueue): TInfo;
begin
	if thisQueue.count = 0 then exit;
	result := thisQueue.queue[thisQueue.first];
	thisQueue.count -= 1;
	thisQueue.first += 1;
	if thisQueue.first = thisQueue.size then thisQueue.first := 0;
end;

///- add(var thisQueue: TQueue; info: TInfo)
/// Добавление нового элемента в очередь
procedure add(var thisQueue: TQueue; info: TInfo);
var blocksToAdd: integer;
begin
	if thisQueue.count = thisQueue.size then begin
		blocksToAdd := thisQueue.first div block + 1;
		setLength(thisQueue.queue, thisQueue.size + blocksToAdd * block);
		for i: integer := 0 to thisQueue.first - 1 do
			thisQueue.queue[i + thisQueue.size] := thisQueue.queue[i];
		thisQueue.last += thisQueue.size;
		thisQueue.size += (blocksToAdd * block);
	end;
	thisQueue.queue[thisQueue.last] := info;
	thisQueue.last += 1;
	if thisQueue.last = thisQueue.size then thisQueue.last := 0;
	thisQueue.count += 1;
end;

end.