unit myStack;
	
interface
type 	
		/// TInfo - базовый тип структуры
		TInfo = integer;
		TStack = record
			stack: array of TInfo;
			n: integer;
		end;

procedure init(var thisStack: TStack); overload;
function isEmpty(thisStack: TStack): boolean; overload;
procedure push(var thisStack: TStack; info: TInfo);
function pop(var thisStack: TStack): TInfo;

implementation
///- init(var thisStack: TStack)
/// Инициализация стека
procedure init(var thisStack: TStack); overload;
begin
	thisStack.n := 0;
	setLength(thisStack.stack, 0);
end;


///- isEmpty(thisStack: TStack)
/// Проверка: пуст ли стек
function isEmpty(thisStack: TStack): boolean; overload;
begin
	result := thisStack.n = 0;
end;


///- push(var thisStack: TStack; info: TInfo)
/// Добавление нового элемента в стек
procedure push(var thisStack: TStack; info: TInfo);
begin
	thisStack.n += 1;
	setLength(thisStack.stack, thisStack.n);
	thisStack.stack[thisStack.n - 1] := info;
end;


///- pop(var thisStack: TStack)
/// Получение (и удаление) элемента из стека
function pop(var thisStack: TStack): TInfo;
begin
	if thisStack.n <> 0 then begin
		result := thisStack.stack[thisStack.n - 1];
		thisStack.n -= 1;
		setLength(thisStack.stack, thisStack.n);
	end;
end;


end.