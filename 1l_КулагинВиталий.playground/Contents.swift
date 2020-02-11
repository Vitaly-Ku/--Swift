import UIKit

//задание 1
let a: Double = 1
let b: Double = -8
let c: Double = 12

let discriminant = b * b - 4 * a * c

let x1 = (-b + sqrt(discriminant)) / (2 * a)
let x2 = (-b - sqrt(discriminant)) / (2 * a)

a * (x1 * x1) + b * x1 + c

//задание 2
let leg1: Double = 2
let leg2: Double = 10

let hypotenuse = sqrt(leg1 * leg1 + leg2 * leg2)
let square = leg1 * leg2 / 2
let perimeter = leg1 + leg2 + hypotenuse

//задание 3
func getPercent (deposit: Double, percent: Double, time: Int) -> Int {
    let percent = (percent / Double(12)) / 100//приведение % в формат
    let monthPercent = deposit * percent//накопление за месяц
    var sumAfterMonth = deposit + monthPercent//сумма с % через месяц

    for i in 1..<time {
        sumAfterMonth += (sumAfterMonth * percent)
        print("Месяц \(i + 1) : \(Int(sumAfterMonth))")
    }

    return Int(sumAfterMonth)
}
getPercent(deposit: 234000, percent: 7.65, time: 60)

