import pyautogui as pg

pg.hotkey("altleft", "tab")
# добавление элементов в стек
pg.typewrite("3\n5\n13\n6\n\t\n")
# удаление элементов из стека
pg.typewrite("5\n")
# добавление элементов в очередь
pg.typewrite("36\n5\n8\n6\n-5\n-10\n\t\n")
# удаление элементов из очереди
pg.typewrite("9\n")
# добавление элементов в начало дека
pg.typewrite("42\n35\n-4\n6\n-25\n-13\n\t\n")
# добавление элементов в конец дека
pg.typewrite("24\n2\n5\n7\n\t\n")
# удаление нескольких элементов из начала дека
pg.typewrite("7\n")
# удаление нескольких элементов с конца дека
pg.typewrite("4\n")