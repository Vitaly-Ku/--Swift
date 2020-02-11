import UIKit

/* Описание:
 Свиноферма.
 Методы:
 1. - Покормить свинью
 2. - Убить свинью и зачислить её сытость к общему запасу корма для свиней (канибализм получается, к сожалению)))
 Свойства:
 1. - Словарь из имён свиней и их сытостью
 2. - рацион (одно кормление)
 3. - максимальная сытость
 4. - запас корма
 Ошибки (возможные): в зависимости от рандома сытости свиньи - может сработать любая из трёх ошибок
 1. - обращение к несуществующей свинье
 2. - иссяк запас корма
 3. - покормить полностью сытую свинью нельзя = nil
*/

enum FarmError: Error {
    case invalidSelection // обращение к несуществующей свинье
    case emptyStock // иссяк запас корма
    case overfilledPig // покормить полностью сытую свинью нельзя = nil
}

class PigFarm {
    var pigSatiety: [String : Int] = [:] // имена : сытость
    var ration = 40 // рацион (одно кормление)
    var maxSatiety = 100 // максимальная сытость
    var feedStock = Int.random(in: 110...130) // запас корма (для интереса - пусть будет рандомный)
    
    func feed(_ name: String) throws -> Int { // функция кормления свиньи
        guard pigSatiety[name] != nil else { // проверка на наличие имени
            throw FarmError.invalidSelection
        }
        guard pigSatiety[name]! < 100 else { // если сытость 100 - кормить нельзя
            throw FarmError.overfilledPig
        }
        guard feedStock > ration else { // закончился корм
            throw FarmError.emptyStock
        }
        feedStock -= ration // уменьшение запаса корма на 1 кормление
        
        pigSatiety[name]! += ration // кормление свиньи
        
        if pigSatiety[name] ?? 0 > maxSatiety { // если сытость болше максимума, то сытость = максимум
            pigSatiety[name] = maxSatiety
        }
        return pigSatiety[name]! // unwrapped тут, я так понимаю обязателен из-за словаря(-> опционал)
    }
    
    func killPigForStock(_ name: String) throws -> Int? { // зарезать свинью для пополнения запаса корма (+ её сытость)
        guard pigSatiety[name] != nil else {
            throw FarmError.invalidSelection
        }
        feedStock += pigSatiety[name] ?? 0
        pigSatiety.removeValue(forKey: name)
        return feedStock
    }
}
let pigFarm = PigFarm()
/*
добавляем хрюшек и присваиваем им сытость.
(0...30) - это подобранный вручную диапазон для наглядности срабатывания ошибок
(чтобы был шанс выпасть любой из трёх ошибок)
*/
pigFarm.pigSatiety["Даша"] = Int.random(in: 0...30)
pigFarm.pigSatiety["Маша"] = Int.random(in: 0...30)
pigFarm.pigSatiety["Саша"] = Int.random(in: 0...30)
pigFarm.pigSatiety["Паша"] = Int.random(in: 0...30)
pigFarm.pigSatiety["Каша"] = Int.random(in: 0...30)

do { // в зависимости от рандома сытости - может сработать любая из трёх ошибок
    try pigFarm.feed("Даша") // покормить хрюшку "Даша"
    try pigFarm.feed("Даша") //
    try pigFarm.feed("Даша")
    try pigFarm.feed("zzzz") // обращение к несуществующей свинье
} catch FarmError.invalidSelection {
    print("обращение к несуществующей свинье")
} catch FarmError.emptyStock {
    print("иссяк запас корма")
} catch FarmError.overfilledPig {
    print("покормить полностью сытую свинью нельзя")
}

pigFarm.feedStock // корма осталось

do {
    try pigFarm.killPigForStock("Саша") // зарезали одну, пополнили запас на + её сытость
} catch FarmError.invalidSelection {
    print("обращение к несуществующей свинье")
}

pigFarm.pigSatiety.count // количесто свиней

print(pigFarm.pigSatiety) // список всех свиней с сытостью
