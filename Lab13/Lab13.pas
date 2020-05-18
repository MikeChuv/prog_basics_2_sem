// вариант 31
// целые числа от -50 до +50
// четные числа

program lab13;

uses myTree; 

const 	
		INDEX_EXCEPTION = 'Недостаточно параметров';
		FILE_EXCEPTION = 'Невозможно открыть файл';
		FORMAT_EXCEPTION = 'Входная строка имела неверный формат. Некорректные данные в файле. ';
		

var 
	/// Входной файл
	fin: textfile;
	/// Обрабатываемое дерево
	thisTree: PNode;
	/// Найденная вершина
	subTree: PNode;
	/// Добавляемый элемент
	thisInfo: TInfo;
	/// Вспомогательная строка для продолжения ли прекращения ввода и выбора
	userChoice: string;

begin
	try		
		// ввести дерево из файла;
		thisTree := readTree(ParamStr(1));
		if thisTree = nil then writeln('Дерево пусто. Проверьте входной файл.')
		else begin
			printTree(thisTree);
			// добавить к дереву несколько вершин (сначала ищем нужную вершину, затем добавляем к ней подвершину);
			writeln('Добавление вершин.');
			while true do begin // цикл выбора вершины
				write('Введите вершину, которую надо найти: ');
				readln(thisInfo);
				subTree := search(thisTree, thisInfo);
				if subTree = nil then writeln('Вершина не найдена')
				else begin
					if (subTree^.left = nil) and (subTree^.right = nil) then begin
						write('Какую подвершину добавить? [л(левая)/п(правая)]: ');
						readln(userChoice);
						if userChoice = 'п' then begin
							write('Введите значение: ');
							readln(thisInfo);
							if addNodeRight(subTree, thisInfo) then printTree(thisTree)
							else writeln('Вне диапазона. Не добавлено.');
						end
						else if userChoice = 'л' then begin
							write('Введите значение: ');
							readln(thisInfo);
							if addNodeLeft(subTree, thisInfo) then printTree(thisTree)
							else writeln('Вне диапазона. Не добавлено.');
						end
						else writeln('Не распознано.');
					end
					else if (subTree^.left = nil) then begin
						write('Возможно добавление только в левую подвершину. Введите значение: ');
						readln(thisInfo);
						if addNodeLeft(subTree, thisInfo) then printTree(thisTree)
						else writeln('Вне диапазона. Не добавлено.');
					end
					else if (subTree^.right = nil) then begin
						write('Возможно добавление только в правую подвершину. Введите значение: ');
						readln(thisInfo);
						if addNodeRight(subTree, thisInfo) then printTree(thisTree)
						else writeln('Вне диапазона. Не добавлено.');
					end
					else begin
						writeln('Вершина имеет две подвершины. Добавление невозможно.');
					end;
				end;
				write('Продолжить выбор вершины и добавление? [д/н]: ');
				readln(userChoice);
				if (userChoice <> 'д') then break;
			end;
			// удалить из дерева несколько вершин (сначала ищем нужную вершину, затем удаляем её);
			writeln('Удаление вершин.');
			while thisTree <> nil do begin
				write('Введите вершину, которую надо найти и удалить: ');
				readln(thisInfo);
				subTree := search(thisTree, thisInfo);
				if subTree = nil then writeln('Вершина не найдена.')
				else begin
					deleteSubTree(thisTree, thisInfo);
					printTree(thisTree);
				end; 
				write('Продолжить удаление? [д/н]: ');
				readln(userChoice);
				if (userChoice <> 'д') then break;
			end;
			if thisTree = nil then writeln('Дерево уделено полностью.');
			// найти количество элементов дерева, удовлетворяющих условию.
			writeln('Количество элементов дерева, удовлетворяющих условию: ' ,count(thisTree));
			delete(thisTree);
			printTree(thisTree);
		end;
	except
	on System.IndexOutOfRangeException do writeln(INDEX_EXCEPTION);
	on System.IO.FileNotFoundException do writeln(FILE_EXCEPTION);
	on System.FormatException do writeln(FORMAT_EXCEPTION);
	end;
	
end.
