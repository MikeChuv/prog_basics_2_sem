// вариант 31
// целые числа от -50 до +50
// по убыванию модуля
// четный элемент

program lab11;

uses oneDirListLib; //oneDirListLib,twoDirListLib

const 	INDEX_EXCEPTION = 'Недостаточно параметров';
		FILE_EXCEPTION = 'Невозможно открыть файл';
		

var fin: textfile;
	myList: TList;
	inTmpStr: string;
	thisInfo: integer;
	firstByCondition, lastByCondition: PElem;


begin
	try
		assignfile(fin,ParamStr(1));
		reset(fin);
		init(myList);
		// ввести список
		readList(fin, myList);
		writeln('Список после ввода из файла:');
		printList(myList); // вывод списка

		// добавить несколько в начало и в конец
		writeln('Введите несколько чисел для добавления в начало списка. Ввод оканчивается вещественным числом или символом');
		readln(inTmpStr);
		while integer.TryParse(inTmpStr,thisInfo) do begin
    		writelnFormat('Преобразовано к целому: {0}',thisInfo);
			addToBegin(myList, thisInfo);
			readln(inTmpStr);
		end;
		writeln('Ввод и добавление в начала окончены.');
		writeln('Введите несколько чисел для добавления в конец списка. Ввод оканчивается вещественным числом или символом');
		readln(inTmpStr);
		while integer.TryParse(inTmpStr,thisInfo) do begin
    		writelnFormat('Преобразовано к целому: {0}',thisInfo);
			addToEnd(myList, thisInfo);
			readln(inTmpStr);
		end;
		writeln('Ввод и добавление в конец окончены.');
		printList(myList); // вывод списка

		// найти первый (и последний) элемент по заданному условию
		search(myList, firstByCondition, lastByCondition);
		if firstByCondition <> nil then writeln('Первый элемент по заданному условию: ', firstByCondition^.info);
		if lastByCondition <> nil then writeln('Последний элемент по заданному условию: ', lastByCondition^.info);
		if (firstByCondition = nil) and  (lastByCondition = nil) then writeln('Нет элементов по заданному условию');

		// удалить элементы из списка по заданному условию
		deleteElements(myList);
		writeln('После удаления элементов из списка по заданному условию');
		printList(myList); // вывод списка

		// удалить список
		deleteList(myList);
		writeln('После удаления списка');
		printList(myList); // вывод списка
		if isEmpty(myList) then writeln('Список пуст');

		reset(fin);

		// ввести с сохранением порядка
		readListByCondition(fin, myList);
		writeln('Ввод с сохранением порядка');
		printList(myList); // вывод списка

		// найти первый (и последний) элемент по заданному условию
		search(myList, firstByCondition, lastByCondition);
		if firstByCondition <> nil then writeln('Первый элемент по заданному условию: ', firstByCondition^.info);
		if lastByCondition <> nil then writeln('Последний элемент по заданному условию: ', lastByCondition^.info);
		if (firstByCondition = nil) and  (lastByCondition = nil) then writeln('Нет элементов по заданному условию');

		// удалить элементы из списка по заданному условию
		deleteElements(myList);
		writeln('После удаления элементов из списка по заданному условию');
		printList(myList); // вывод списка

		// удалить список
		deleteList(myList);
		writeln('После удаления списка');
		printList(myList); // вывод списка
		if isEmpty(myList) then writeln('Список пуст');

		closefile(fin);
	except
	on System.IndexOutOfRangeException do writeln(INDEX_EXCEPTION);
	on System.IO.FileNotFoundException do writeln(FILE_EXCEPTION);
	end;
	
end.
