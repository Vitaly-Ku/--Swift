import UIKit

//задание 1
func checkParity (_ num: Int) -> String {
    return num % 2 == 0 ? "чётное" : "не чётное"
}

//задание 2
func checkDivisiion (_ num: Int) -> Bool {
    return num % 3 == 0 ? true : false
}

//задание 3
var array = Array (1...100)//самый простой способ!!

//задание 4
for i in array {
    if (i % 2) == 0 || (i % 3) != 0 {
        array.remove(at: array.firstIndex(of: i)!)
    }
}
array

//задание 5*
func fib(_ n: Int) -> [Decimal] {//без Decimal - считает только до 90 чисел в последовательности
    var arr: [Decimal] = []
    var a: Decimal = 0
    var b: Decimal = 1

    for _ in 0..<n {
        a += b
        b = a - b
        arr.append(a)
    }
    return arr
}
print(fib(100))

//задание 6*
func isPrime(_ number: Int) -> Bool {
    return !(2..<number).contains { number % $0 == 0 }
}
for i in 2...546 {
    if isPrime(i) {
        print(i)
    }
}
