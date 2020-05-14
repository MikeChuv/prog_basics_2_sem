# Лабораторная работа № 12

### Постановка задачи.
**Разработать модули для работы с информационно-логическими структурами – стеком, очередью и деком. Модули должны обеспечивать следующие возможности работы со структурами:**
- инициализацию структуры;
- добавление элемента согласно правилам работы со структурой;
- удаление элемента согласно правилам работы со структурой;
- проверку, что структура пуста. 

**На основе базовых операций со структурами необходимо разработать следующие подпрограммы:**
- ввод элементов структуры из файла – осуществлять ввод до конца файла;
- вывод элементов структуры на экран: стек и очередь выводятся в прямом порядке, дек – в прямом и обратном порядке;
- удаление из структуры указанных элементов: из стека и очереди удалить все элементы, удовлетворяющие условию, из дека удалить элементы, удовлетворяющие условию, если они при этом находятся на одинаковом расстоянии от краёв дека. 

##### Вариант 31:
- целые числа от -50 до +50
- искать или удалять (условие): четный элемент

### Входная форма
*В файле:*
Целые числа от -50 до +50 через пробел \
*При добавлении элементов в начало и конец:* \
Введите несколько чисел для добавления в начало (конец). Ввод оканчивается вещественным числом или символом
*При удалении элементов* \
Вводится количество элементов, которое необходимо удалить
### Выходная форма
Стек после ввода из файла: \< стек > \
Стек после добавления элементов: \< стек > \
Стек после удаления `n` элементов: \< стек > \
После удаления элементов из стека по заданному условию: \< стек > \
Очередь после ввода из файла: \< очередь > \
Очередь после добавления элементов: \< очередь > \
Очередь после удаления `n` элементов: \< очередь > \
После удаления элементов из очереди по заданному условию: \< очередь > \
Дек после ввода из файла: \< дек > \
Дек после добавления в начало: \< дек > \
Дек после добавления в конец: \< дек > \
Дек после удаления из начала `n` элементов: \< дек > \
Дек после удаления с конца `n` элементов: \< дек > \
После удаления элементов из дека по заданному условию: \< дек > \  
### Аномалии
- Недостаточно параметров
- Невозможно открыть файл
- Добавляемое значение не попадает в заданный диапазон.
- Некорректные данные в файле.
- Значения в текстовом файле не попадают в заданный диапазон.

### Тестовые примеры
`input.txt` - Есть элементы, удовлетворяющие условию. \
`input2.txt` - Все элементы удовлетворяют условию. Количество элементов нечётно, поэтому в деке остаётся один элемент. \
`input3.txt` - Все элементы удовлетворяют условию. Количество элементов чётно, поэтому в деке не остаётся элементов. \
`input4.txt`, test 4 - Есть элементы, удовлетворяющие условию.
В деке нет совпадающих пар. \
*Тесты, проведенные мной, есть в файле* `myTests.log`. *При тестировании также использовался python-скрипт из файла* `pyTest.py`
### Метод
При выводе перекладываем элементы из данной структуры в аналогичную и выводим их. Затем перекладываем элементы обратно. \
**Для стека:** \
*При удалении элемента из стека:* \
Берём элемент из стека. Если он не удовлетворяет условию, кладём его в другой стек. Таким образом, выбираем все элементы исходного стека. Когда исходный стек станет пуст, перекладываем элементы из дополнительного стека обратно в исходный. \
**Для очереди** \
*При удалении элемента из стека:* \
Перемещаем элементы, не удовлетворяющие условию, из исходной в дополнительную очередь, а потом обратно. \
**Для дека** \
*При удалении элемента из дека:* \
Берем по элементу с каждой стороны дека(если остался только один элемент берем только его). Если хотя бы один из них не удовлетворяет условию, кладем его в соответствующий дополнительный дек(*"голова"* и *хвост*). После освобождения исходного дека, перекладываем элементы обратно. 