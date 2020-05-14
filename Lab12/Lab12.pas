// вариант 31
// целые числа от -50 до +50
// четные числа

program lab12;

uses labUtils, myStack, myQueue, myDeque; 

const 	INDEX_EXCEPTION = 'Недостаточно параметров';
		FILE_EXCEPTION = 'Невозможно открыть файл';
		FORMAT_EXCEPTION = 'Входная строка имела неверный формат. Некорректные данные в файле. ';
		ADD_NUM_PROMPT = 'Для добавление вводите числа через Enter. Ввод заканчивается нецелым числом или буквой';
		

var 
	/// Входной файл
	fin: textfile;
	/// Стек
	thisStack: TStack;
	/// Очередь
	thisQueue: TQueue;
	/// Дек
	thisDeque: TDeque;
	/// Считанное или полученное число
	thisInfo: TInfo;
	/// Кол-во элементов для удаления
	numElems: integer;
	/// Вспомогательная строка для ввода новых элементов
	inTmpStr: string;
	/// i - счетчик удаляемых элементов
	i: integer;

begin
	try
		assignfile(fin,ParamStr(1));
		reset(fin);


		init(thisStack);
		// ввод из файла в стек
		readStack(thisStack, fin);
		writeln('Стек после ввода из файла: ');
		printStack(thisStack);

		// добавление элементов в стек
		writeln(ADD_NUM_PROMPT);
		readln(inTmpStr);
		while integer.TryParse(inTmpStr,thisInfo) do begin
			// writelnFormat('Преобразовано к целому: {0}',thisInfo);
			if ((thisInfo >= -50) and (thisInfo <= 50)) then push(thisStack, thisInfo)
			else writeln('Элемент вне границ диапазона. Элемент не добавлен');
			readln(inTmpStr);
		end;
		writeln('Стек после добавления элементов: ');
		printStack(thisStack);

		// удаление элементов из стека
		write('Сколько элементов удалить из стека? : ');
		readln(numElems);
		i := 1;
		while (not isEmpty(thisStack) and (i <= numElems)) do begin
			thisInfo := pop(thisStack);
			i += 1;
		end;
		writelnFormat('Стек после удаления {0} элементов:', numElems);
		printStack(thisStack);

		// удаление из стека элементов по заданному условию
		deleteElemsByConditionFromStack(thisStack);
		writeln('После удаления элементов из стека по заданному условию');
		printStack(thisStack);

		reset(fin);


		init(thisQueue);

		// ввод из файла в очередь
		readQueue(thisQueue, fin);
		writeln('Очередь после ввода из файла: ');
		printQueue(thisQueue);

		// добавление элементов в очередь
		writeln(ADD_NUM_PROMPT);
		readln(inTmpStr);
		while integer.TryParse(inTmpStr,thisInfo) do begin
			// writelnFormat('Преобразовано к целому: {0}',thisInfo);
			if ((thisInfo >= -50) and (thisInfo <= 50)) then add(thisQueue, thisInfo)
			else writeln('Элемент вне границ диапазона. Элемент не добавлен');
			readln(inTmpStr);
		end;
		writeln('Очередь после добавления элементов: ');
		printQueue(thisQueue);

		// удаление элементов из очереди
		write('Сколько элементов удалить из очереди? : ');
		readln(numElems);
		i := 1;
		while (not isEmpty(thisQueue) and (i <= numElems)) do begin
			thisInfo := get(thisQueue);
			i += 1;
		end;
		writelnFormat('Очередь после удаления {0} элементов:', numElems);
		printQueue(thisQueue);

		// удаление из очереди элементов по заданному условию
		deleteElemsByConditionFromQueue(thisQueue);
		writeln('После удаления элементов из очереди по заданному условию');
		printQueue(thisQueue);


		reset(fin);


		init(thisDeque);

		// ввод из файла в дек
		readDeque(thisDeque, fin);
		writeln('Дек после ввода из файла: ');
		printDeque(thisDeque);

		// добавление элементов в начало дека
		writeln('Добавление элементов в начало дека');
		writeln(ADD_NUM_PROMPT);
		readln(inTmpStr);
		while integer.TryParse(inTmpStr,thisInfo) do begin
			// writelnFormat('Преобразовано к целому: {0}',thisInfo);
			if ((thisInfo >= -50) and (thisInfo <= 50)) then addToBegin(thisDeque, thisInfo)
			else writeln('Элемент вне границ диапазона. Элемент не добавлен');
			readln(inTmpStr);
		end;
		writeln('Дек после добавления в начало: ');
		printDeque(thisDeque);

		// добавление элементов в конец дека
		writeln('Добавление элементов в конец дека');
		writeln(ADD_NUM_PROMPT);
		readln(inTmpStr);
		while integer.TryParse(inTmpStr,thisInfo) do begin
			// writelnFormat('Преобразовано к целому: {0}',thisInfo);
			if ((thisInfo >= -50) and (thisInfo <= 50)) then addToEnd(thisDeque, thisInfo)
			else writeln('Элемент вне границ диапазона. Элемент не добавлен');
			readln(inTmpStr);
		end;
		writeln('Дек после добавления в конец: ');
		printDeque(thisDeque);

		// удаление нескольких элементов из начала дека
		write('Сколько элементов удалить из начала дека? : ');
		readln(numElems);
		i := 1;
		while (not isEmpty(thisDeque) and (i <= numElems)) do begin
			thisInfo := getFromBegin(thisDeque);
			i += 1;
		end;
		writelnFormat('Дек после удаления из начала {0} элементов:', numElems);
		printDeque(thisDeque);

		// удаление нескольких элементов с конца дека
		write('Сколько элементов удалить с конца дека? : ');
		readln(numElems);
		i := 1;
		while (not isEmpty(thisDeque) and (i <= numElems)) do begin
			thisInfo := getFromEnd(thisDeque);
			i += 1;
		end;
		writelnFormat('Дек после удаления с конца {0} элементов:', numElems);
		printDeque(thisDeque);
		// удаление из дека элементов по заданному условию
		writeln('После удаления элементов из дека по заданному условию');
		deleteElemsByConditionFromDeque(thisDeque);
		printDeque(thisDeque);

		closefile(fin);
	except
	on System.IndexOutOfRangeException do writeln(INDEX_EXCEPTION);
	on System.IO.FileNotFoundException do writeln(FILE_EXCEPTION);
	on System.FormatException do writeln(FORMAT_EXCEPTION);
	end;
	
end.
