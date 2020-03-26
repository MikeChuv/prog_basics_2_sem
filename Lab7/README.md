# Лабораторная работа № 6

#### Постановка задачи.
Если в одномерном массиве a из n элементов нет элементов, модуль которого попадает в заданный диапазон, найти сумму элементов массива, для которых выполняется условие a[i] ^ 2 > i. 

#### Таблица данных

| Класс | Имя | Смысл | Тип | Структура |
| ---- | --- | ----- | --- | --------- |
| Входные данные | --- | ----- | --- | --------- |
| Выходные данные | --- | ----- | --- | --------- |

#### Входная форма

#### Выходная форма

#### Аномалии

#### Тестовые примеры
| № Теста | Входные данные | Ожидаемые результаты |
| ------- | -------------- | -------------------- |

#### Метод
Вводим интервал, в который должны попадать элементы массива и проверяем их на положительность.
Если диапазон задан неверно выводим сообщение, иначе водим массив.
Если в массиве нет элементов, подуль которых попадает в интервал, то ищем сумму, иначе выводим сообщение о том, что в массиве есть нужные элементы.
#### Алгоритм
![Алгоритм]()

#### Программа
```pascal
program lab6;

uses myRecursion;

const 	INDEX_EXCEPTION = 'Недостаточно параметров';
		FILE_EXCEPTION = 'Невозможно открыть файл';
		INTERVAL_OUT_OF_RANGE = 'Границы диапазона заданы неверно';

var fin,fout: textfile;
	a: vec;
	n: integer;
	intervalBegin, intervalEnd: real;
	thisSum: real;
begin
	try
		assignfile(fin,ParamStr(1));
		reset(fin);
		assignfile(fout,ParamStr(2));
		rewrite(fout);
		readln(fin, intervalBegin, intervalEnd);
		if (intervalBegin < 0) or (intervalEnd < 0) or (intervalBegin > intervalEnd) then 
			writeln(INTERVAL_OUT_OF_RANGE)
		else begin
			readVec(a,fin);
			writeVec(a,fout);
			if not areInInterval(a, 0, intervalBegin,intervalEnd) then begin
				thisSum := sum(a);
				writeln(fout,'Sum = ', thisSum);
			end
			else writeln(fout, 'Array has elements with abs in range: ', 
						intervalBegin, ' ',intervalEnd);
		end;
		

		
		closefile(fin);
		closefile(fout);
	except
	on System.IndexOutOfRangeException do writeln(INDEX_EXCEPTION);
	on System.IO.FileNotFoundException do writeln(FILE_EXCEPTION);
	end;
    
end.
```

#### Модуль
```pascal
unit myRecursion;

interface
type vec = array of real;
procedure readVec(var x: vec; f:textfile);
procedure writeVec(const x: vec; f:textfile);
function areInInterval(const x: vec; startIndex: integer; intervalBegin,intervalEnd:real):boolean;
function sum(const x: vec):real;


implementation

function areInInterval(const x: vec; startIndex: integer; intervalBegin,intervalEnd:real):boolean;
var stopIndex: integer;
begin
	stopIndex := High(x);
	if startIndex = stopIndex then
		result := (abs(x[startIndex]) > intervalBegin) and (abs(x[startIndex]) < intervalEnd)
	else
	begin
		result := 	(abs(x[startIndex]) > intervalBegin) and 
					(abs(x[startIndex]) < intervalEnd) or 
					areInInterval(x, startIndex + 1, intervalBegin,intervalEnd);
	end;
end;

procedure readVec(var x: vec; f:textfile);
var n:integer;
begin
	readln(f, n);
	SetLength(x,n);
	for i: integer := 0 to n-1 do begin
		read(f, x[i]);
	end;
end;


procedure writeVec(const x: vec; f:textfile);
var i: integer;
begin
 	for i := 0 to High(x) do begin
		write(f, x[i], '  ');
	end;
	writeln(f);
end;

function sum(const x: vec):real;
begin
	result := 0;
	for i:integer :=0 to High(x) do begin
		if power(x[i],2) > i then result += x[i];
	end;
end;



end.

```