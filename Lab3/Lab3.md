# Лабораторная работа № 3

#### Постановка задачи.

####  Уточнение постановки задачи

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

#### Алгоритм
![Алгоритм]()

#### Программа
```pascal
program lab3;
uses mysetarray;


var
	csets: SetsArray;
	thisset: myset;
	n, equals, colls, i: integer;
	fin,fout: textfile;
	errorIndexMsg, errorFileMsg: string;
	ch: char;

begin

	errorIndexMsg := 'Недостаточно параметров или выход за предел описания массива';
	errorFileMsg := 'Невозможно открыть файл для чтения';
	try
		//write(chr(200));
		assignfile(fin,ParamStr(1));
		reset(fin);
		assignfile(fout, ParamStr(2));
		rewrite(fout);
		readMySetArray(csets,n,fin);
		writeln(fout, 'Number of sets = ',n);
		writeln(fout,'==================================================');
		writeln(fout, 'Hash-codes from Hash3 function: ');
		for i := 1 to n do begin
			writeln(fout,Hash3(csets[i]));
		end;
		writeln(fout);
		findCollsEqualsH3(csets,n,colls,equals);	
		writeln(fout,'colls = ', colls );
		writeln(fout,'equals = ', equals);

		closefile(fin);
		closefile(fout);
	except
		on System.IndexOutOfRangeException do writeln(errorIndexMsg);
		on System.IO.FileNotFoundException do writeln(errorFileMsg);
		
	end;
	
end.


```
