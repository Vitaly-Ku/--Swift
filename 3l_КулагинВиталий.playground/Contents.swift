import Foundation

enum EngineMode {
    case on, off
}
enum WindowsMode {
    case on, off
}

struct Car {
    enum Brand {
        case BMW, Lada, Mersedes, Niva, Jeep
    }
    var brand: Brand
    var release: Int
    var trunk: Double
    var engineMode: EngineMode = .off
    var windowsMode: WindowsMode = .on
    var trunkFill: Double
    
    mutating func changeEngineMode(_ mode: EngineMode) {
        self.engineMode = mode
    }
    mutating func changeWindowsMode(_ mode: WindowsMode) {
        self.windowsMode = mode
    }
}

var niva1 = Car.init(brand: .Niva, release: 1985, trunk: 500, engineMode: .on, windowsMode: .off, trunkFill: 347.5)//инициализатор с переопределяемыми значениями, которые выставлены по умолчанию (.engineMode, .windowsMode)
var jeep1 = Car.init(brand: .Jeep, release: 2010, trunk: 550, trunkFill: 0)//со значениями по умолчанию

niva1.changeEngineMode(.off)
print(niva1)


//**************************************************************************************************************************************
struct Truck {
    enum Brand {
        case Volvo, Ford, MAN, Iveco, Kamaz
    }
    var brand: Brand
    var release: Int
    var trunk: Double
    var engineMode: EngineMode = .off
    var windowsMode: WindowsMode = .on
    var trunkFill: Double
    
    mutating func changeEngineMode(_ mode: EngineMode) {
        self.engineMode = mode
    }
    mutating func changeWindowsMode(_ mode: WindowsMode) {
        self.windowsMode = mode
    }
    
    init?(brandName: Brand, year: Int, capacity: Double, engine: EngineMode, windows: WindowsMode, filling: Double) {
        if year < 1900 {//опциональный тип структуры, с проверкой на год выпуска
            print("Вероятно введён неверный год выпуска, пожалуйста проверьте")
            return nil
        }
        self.brand = brandName
        self.release = year
        self.trunk = capacity
        self.engineMode = engine
        self.windowsMode = windows
        self.trunkFill = filling
    }
}

var volvo1 = Truck(brandName: .Volvo, year: 2003, capacity: 345, engine: .on, windows: .on, filling: 30.7)

volvo1!.changeWindowsMode(.off)
print(volvo1!)
