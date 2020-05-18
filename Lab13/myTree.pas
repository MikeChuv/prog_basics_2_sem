unit myTree;
	
interface
	
type
	/// TInfo - базовый тип структуры
	TInfo = integer;
	/// указатель на дерево (вершину дерева)
	PNode = ^TNode;

	TNode = record
		info: TInfo;
		left, right: PNode;
	end;
	
function readTree(fileName: string): PNode; overload;
procedure printTree(tree: PNode); overload;
procedure delete(var root: PNode);
function count(tree: PNode): integer;
function search(tree: PNode; thisInfo: TInfo): PNode;
function addNode(var newNode: PNode; info: TInfo): boolean;
function addNodeLeft(var tree: PNode; info: TInfo): boolean;
function addNodeRight(var tree: PNode; info: TInfo): boolean;
function addRoot(var newRoot: PNode; info: TInfo): boolean;
procedure deleteSubTree(var tree: PNode; info: TInfo);

implementation
const
	RANGE_BEGIN = -50;
	RANGE_END = 50;
///- readTree(fileName: string): PNode
/// ввод элементов бинарного дерева из файла
function readTree(fileName: string): PNode; overload;
var
	fin: textfile;
	info: string;
	tmpTree,subTree: PNode;

	function readTree(): PNode; overload;
	begin
		readln(fin, info);
		if info = '*' then result := nil
		else if (StrToInt(info) >= RANGE_BEGIN) and (StrToInt(info) <= RANGE_END) then begin
			new(result);
			result ^.info := StrToInt(info);
			result ^.left := readTree();
			result ^.right := readTree();
		end
		else begin
			new(result);
			result ^.info := RANGE_END + 1;
			result ^.left := readTree();
			result ^.right := readTree();
		end;
	end;

begin
	assignFile(fin, fileName);
	reset(fin);
	tmpTree := readTree();
	while true do begin
		subTree := search(tmpTree, RANGE_END + 1);
		if subTree <> nil then begin
			deleteSubTree(tmpTree, RANGE_END + 1);
		end
		else break;
	end;
	result := tmpTree;
	closeFile(fin);
end;

///- printTree(tree: PNode)
/// вывод элементов бинарного дерева на экран
procedure printTree(tree: PNode); overload;
	procedure printTree(tree: PNode; n: integer); overload;
	begin
		if tree = nil then exit;
		printTree(tree^.right, n + 1);
		write('  ' * n);
		writeln(tree^.info);
		printTree(tree^.left, n + 1);
	end;
begin
	printTree(tree, 0);
end;

///- delete(var root: PNode)
/// удаление подвершин
procedure delete(var root: PNode);
begin
	if root <> nil then begin
		delete(root^.left);
		delete(root^.right);
		dispose(root);
		root := nil;
	end;
end;

///- count(tree: PNode): integer
/// определение количества вершин дерева, удовлетворяющих условию
function count(tree: PNode): integer;
begin
	if tree = nil then result := 0
	else result := count(tree^.left) + ord(tree^.info mod 2 = 0) + count(tree^.right);
end;

///- search(tree: PNode; thisInfo: TInfo): PNode
/// поиск вершины, содержащей определённую информацию
function search(tree: PNode; thisInfo: TInfo): PNode; overload;
begin
	if tree = nil then result := nil
	else if tree^.info = thisInfo then result := tree
	else begin
		result := search(tree^.left, thisInfo);
		if result = nil then result := search(tree^.right, thisInfo);
	end;
end;

///- addNode(var newNode: PNode; info: TInfo)
/// добавление вершины
function addNode(var newNode: PNode; info: TInfo): boolean;
begin
	if (info >= RANGE_BEGIN) and (info <= RANGE_END) then begin
		new(newNode);
		newNode^.left := nil;
		newNode^.right := nil;
		newNode^.info := info;
		result := true;
	end
	else result := false;
end;

///- addNodeLeft(var tree: PNode; info: TInfo)
/// добавление левой подвершины
function addNodeLeft(var tree: PNode; info: TInfo): boolean;
begin
	if tree = nil then exit;
	result := addNode(tree^.left, info);
end;

/// addNodeRight(var tree: PNode; info: TInfo)
/// добавление правой подвершины
function addNodeRight(var tree: PNode; info: TInfo): boolean;
begin
	if tree = nil then exit;
	result := addNode(tree^.right, info);
end;


///- addRoot(var newRoot: PNode; info: TInfo)
/// добавление корневой вершины
function addRoot(var newRoot: PNode; info: TInfo): boolean;
begin
	if newRoot <> nil then begin
		result := false;
		exit;
	end;
	new(newRoot);
	newRoot^.left := nil;
	newRoot^.right := nil;
	newRoot^.info := info;
	result := true;
end;


///- deleteSubTree(var tree: PNode; info: TInfo)
/// удаление вершины и ее подвершин
procedure deleteSubTree(var tree: PNode; info: TInfo); overload;
begin
	if tree = nil then exit;
	if tree^.info = info then delete(tree)
	else begin
		if tree^.left <> nil then begin
			if tree^.left^.info = info then begin
				delete(tree^.left);
				tree^.left := nil;
			end
			else deleteSubTree(tree^.left, info);
		end;
		if tree^.right <> nil then begin
			if tree^.right^.info = info then begin
				delete(tree^.right);
				tree^.right := nil;
			end
			else deleteSubTree(tree^.right, info);
		end;
	end;
end;
	
end.