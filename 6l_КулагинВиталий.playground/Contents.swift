import UIKit

struct Queue<T> {
    var array: [T] = []
    
    mutating func addToEnd(_ el: T) -> [T] {
        array.append(el)
        return array
    }
    
    mutating func takeFirst() -> T {
        array.removeFirst()
    }
    
    mutating func select<T> (_ arr: [T], closure: (T) -> Bool) -> [T] { // функция с замыканием
        var newArr = [T]()
        for i in arr {//перебор массива, который будем передавать в вызове функции
            if closure(i) {//условие, которое будем задавать в замыкании - если true - то...
                newArr.append(i)// ...то добавляем этот элемент массива в новый массив
            }
        }
        print(newArr)
        return newArr
    }
    
    subscript(indexes: Int ...) -> Int {
        var sum = 0
        indexes.forEach {index in
            sum += array[index] as! Int// не понимаю конструкцию типа "as! Int". xCode предложил такой вариант
        }
        return sum
    }
}

var integers = Queue<Int>()

integers.addToEnd(3)
integers.addToEnd(5)
integers.addToEnd(7)
integers.addToEnd(2)
integers.takeFirst()
let sum = integers[1, 2] // сабскрипт
integers.select([77, 88, 65, 99, 43]) {$0 > 66}

var strings = Queue<String>()

strings.addToEnd("Hello")
strings.addToEnd("I'm")
strings.addToEnd("doing")
strings.addToEnd("sixth")
strings.addToEnd("homework")
strings.takeFirst()
print(strings.array)
strings.select(strings.array) {$0 == "doing"} // $0 - сдесь это перебираемый элемент массива

var doubles = Queue<Double>()

doubles.addToEnd(4)
doubles.addToEnd(5.3)
doubles.takeFirst()
doubles.select([3, 3.6, 4.1, 5, 7]) {$0 > 4 && $0 < 7}



//********************************************************************************************************************************
//Пытался сделать функцию высшего порядка по отрисовке выбранного аккорда в консоли, но пока вышло 2 отдельные функции, вызываемые одна в другой. Первая формирует массив нот, входящих в трезвучие, вторая формирует гитарный гриф и отрисовывает на нём табулатуру выбранного аккорда. Тут ещё много недорабток и требуется рефакторинг. Делал на основе функции по отрисовке шахматной доски из интернета...


enum Chords {
    enum Fret: String { // гармонический окрас
        case Major = "Major"
        case Minor = "Minor"
    }
    enum Note: String { // ноты
        case c = "c"
        case d = "d"
        case e = "e"
        case f = "f"
        case g = "g"
        case a = "a"
        case h = "h"
    }
}
typealias akkord = (Chords.Note, Character, Int) // псевдоним для кортежа

func composeСhord(_ tone: Chords.Fret, _ fret: Chords.Note) -> [akkord] { // функция, в аргументах которой выбирается название аккорда (по ноте) и мажор/минор -> возвращает массив кортежей, в который входят 3 ноты из выбранного аккорда (трезвучие)
    
    // TODO:
    // оптимизировать данную функцию, сделать рефакторинг
    
    var arr: [akkord] = []
    switch (tone, fret) {
    case (.Major, .f):
        arr.append((n: .f, x: "0", y: 3))
        arr.append((n: .a, x: "2", y: 5))
        arr.append((n: .c, x: "0", y: 4))
    case (.Minor, .f):
        arr.append((n: .f, x: "0", y: 3))
        arr.append((n: .a, x: "1", y: 5))
        arr.append((n: .c, x: "0", y: 4))
    case (.Major, .c):
        arr.append((n: .c, x: "0", y: 4))
        arr.append((n: .e, x: "2", y: 1))
        arr.append((n: .g, x: "2", y: 3))
    case (.Minor, .c):
        arr.append((n: .c, x: "0", y: 4))
        arr.append((n: .e, x: "1", y: 1))
        arr.append((n: .g, x: "2", y: 3))
    case (.Major, .g):
        arr.append((n: .g, x: "2", y: 3))
        arr.append((n: .h, x: "2", y: 2))
        arr.append((n: .d, x: "0", y: 1))
    case (.Minor, .g):
        arr.append((n: .g, x: "2", y: 3))
        arr.append((n: .h, x: "1", y: 2))
        arr.append((n: .d, x: "0", y: 1))
    case (.Major, .a):
        arr.append((n: .a, x: "4", y: 3))
        arr.append((n: .c, x: "4", y: 2))
        arr.append((n: .e, x: "2", y: 1))
    case (.Minor, .a):
        arr.append((n: .a, x: "4", y: 3))
        arr.append((n: .c, x: "3", y: 2))
        arr.append((n: .e, x: "2", y: 1))
    case (.Major, .d):
        arr.append((n: .d, x: "2", y: 4))
        arr.append((n: .f, x: "1", y: 3))
        arr.append((n: .a, x: "0", y: 2))
    case (.Minor, .d):
        arr.append((n: .d, x: "2", y: 4))
        arr.append((n: .f, x: "0", y: 3))
        arr.append((n: .a, x: "0", y: 2))
    case (.Major, .e):
        arr.append((n: .e, x: "4", y: 4))
        arr.append((n: .g, x: "3", y: 3))
        arr.append((n: .h, x: "2", y: 2))
    case (.Minor, .e):
        arr.append((n: .e, x: "4", y: 4))
        arr.append((n: .g, x: "2", y: 3))
        arr.append((n: .h, x: "2", y: 2))
    case (.Major, .h):
        arr.append((n: .h, x: "4", y: 5))
        arr.append((n: .d, x: "3", y: 4))
        arr.append((n: .f, x: "1", y: 3))
    case (.Minor, .h):
        arr.append((n: .h, x: "4", y: 5))
        arr.append((n: .d, x: "2", y: 4))
        arr.append((n: .f, x: "1", y: 3))
    }
    return arr
}


func printTablature(_ arr: [(n: Chords.Note, x: Character, y: Int)]) { // вывод в консоль табулатуры с выбранным аккордом
    var neck = [String: Character]() // пустой словарь (гитарный гриф)
    let frets: [Character] = ["0", "1", "2", "3", "4"] // гитарные лады ("0" - открытая струна)
    
    let Symbols: [Chords.Note: Character] = [.c: "♪", .d: "♪", .e: "♪", .f: "♪", .g: "♪", .a: "♪", .h: "♪"] // TODO: переделать так, чтобы один раз присвоить символ "♪" для всех нот сразу
    for i in arr {
        neck["\(i.x)\(i.y)"] =  Symbols[i.n]
    }
    for i in 1...6 {// перебор по струнам
        for j in 1...5 {// перебор по ладам
            if neck["\(frets[j-1])\(i)"] == nil {
                neck["\(frets[j-1])\(i)"] = "▭"
            }
            print(neck["\(frets[j-1])\(i)"]!, terminator: "")
        }
        print()
    }
}

// TODO: собрать из двух функций одну с замыканием и сделать вывод аккордов в консоль в строку, а не в столбик

printTablature(composeСhord(.Major, .d))
printTablature(composeСhord(.Minor, .a))
printTablature(composeСhord(.Major, .c))
