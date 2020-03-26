# Лабораторная работа № 1

#### Постановка задачи.
Написать программу для обработки множеств, которая позволяет ввести три множества символов a, b и c и вычислить множество, являющееся:
- объединением множеств a и b;
- пересечением множеств a и b;
- разностью множеств a и b;
- множеством, полученным из множеств a, b и c по формуле (a ∪ b) \\ (b ∪ c).


#### Таблица данных

| Класс | Имя | Смысл | Тип | Структура |
| ---- | --- | ----- | --- | --------- |
| Входные данные | a,b,c | входные множества | множество символов | прост. перем |
| Выходные данные | res | результирующее множество | множество символов | прост. перем |
| Пром. данные   | fin,fout | вх. и вых. файл  | текст. файл | файл |
| Пром. данные   | сh | символ | символ | прост. перем |

#### Входная форма
\< множетво a>
\< множетво b>
\< множетво c>

#### Выходная форма
Объединение множеств a и b
Персечение множеств a и b
Разность множеств a и b
Множество, (a ∪ b) \\ (b ∪ c)
#### Аномалии

- Недостаточно параметров.
- Невозможно открыть файл для чтения.

#### Тестовые примеры
**Входные данные:**
abcdi
cdef
ghij
**Выходные данные:**
Union: abcdefi
Intersection: cd
Difference: abi
Expr: ab

#### Метод
Считываем посимвольно данные из файла и добавляем их в множество
Находим новые множества используя стандартные операторы над типом *set*
Выводим в файл используя цикл и проверку на вхождение символа в множество


#### Программа
```pascal
program Lab1;

type myset = set of char;

var a,b,c,res: myset;
    fin,fout: textfile;
    ch:char;

procedure vvod(var x:myset; f:textfile);
begin
    while not eoln(f) do begin
        read(f,ch);
        Include(x,ch);
    end;
    readln(f);
end;

procedure vivod(var x:myset; f:textfile);
var ch:char;
begin
    for ch:= chr(0) to chr(255) do begin
        if ch in x then write(f,ch);
    end;
    writeln(f);
end;



begin
    if ParamCount < 2 then writeln('Недостаточно параметров!')
    else begin
        if not FileExists(ParamStr(1)) then	      { Проверяем существование файла }
            writeln('Невозможно открыть файл ''', ParamStr(1), ''' для чтения')
            else begin
                AssignFile(fin, ParamStr(1));
                Reset(fin);
                vvod(a,fin);
                vvod(b,fin);
                vvod(c,fin);
                closefile(fin);
                AssignFile(fout, ParamStr(2));
                Rewrite(fout);
                res := a + b; // объединение
                write(fout,'Union: ');
                vivod(res,fout);
                writeln(fout);
                res := a * b; // пересечение
                write(fout,'Intersection: ');
                vivod(res,fout);
                writeln(fout);
                res := a - b;// разность множеств
                write(fout,'Difference: ');
                vivod(res,fout);
                writeln(fout);
                res := (a+b)-(b+c); //(а или б) искл (б или с)
                write(fout, 'Expr: ');
                vivod(res,fout);
                closefile(fout);
                end;
        end;
end.
```
