import UIKit

enum EngineMode {
    case start // для родителя Car работает метод смены режима двигателя start/stop
    case stop // для родителя Car работает метод смены режима двигателя start/stop
    case turboOn // для наследника SportCar добавляется перегруженный метод выбора турбо режима
    case turboOff // для наследника SportCar добавляется перегруженный метод выбора турбо режима
}

enum WindowsMode {
    case open
    case close
}

enum TrailerMode {//для TrunkCar - отцепить/прицепить прицеп
    case unhook
    case hook
}

class Car {
    
    let release: Int
    let trunk: Double
    let doorCount: Int
    let maxSpeed: Int
    let color: String
    var engineMode: EngineMode = .stop
    var windowsMode: WindowsMode
    
    func engineModeChange () { //метод смены режима двигателя start/stop
        if self.engineMode == .stop {
            self.engineMode = .start
            print("Двигатель включен")
        }
        else {
            self.engineMode = .stop
            print("Двигатель выключен")
        }
    }
    
    init(release: Int, trunk: Double, doorCount: Int, maxSpeed: Int, color: String, windowsMode: WindowsMode) {
        self.release = release
        self.trunk = trunk
        self.doorCount = doorCount
        self.maxSpeed = maxSpeed
        self.color = color
        self.windowsMode = windowsMode
    }
}

var car1 = Car(release: 2010, trunk: 550, doorCount: 5, maxSpeed: 210, color: "white", windowsMode: .open) // экземпляр Car

final class SportCar : Car {
    
    let turboAccelerator: Bool // новое свойство наследника
    
    func turboModeChange(_ mode: EngineMode) { // перегруженный метод выбора турбо режима
        self.engineMode = mode
        print("Двигатель в режиме \(mode)")
    }

    init(release: Int, trunk: Double, doorCount: Int, maxSpeed: Int, color: String, windowsMode: WindowsMode, turboAccelerator: Bool) {
        self.turboAccelerator = turboAccelerator
        super.init(release: release, trunk: trunk, doorCount: doorCount, maxSpeed: maxSpeed, color: color, windowsMode: windowsMode)
    }
}

var sportCar1 = SportCar(release: 2017, trunk: 250, doorCount: 3, maxSpeed: 220, color: "Red", windowsMode: .open, turboAccelerator: true)

car1.engineMode
car1.engineModeChange() // только автоматически включает/выключает мотор (turbo недоступен)
car1.engineMode
car1.engineModeChange() // только автоматически включает/выключает мотор (turbo недоступен)
car1.engineMode

sportCar1.engineMode
sportCar1.engineModeChange() // метод родителя (без аргументов) - вкл/выкл мотор
sportCar1.engineMode
sportCar1.turboModeChange(.turboOn) // метод наследника (с аргументом) - выбирает режим турбо (on/off)
sportCar1.engineMode
sportCar1.turboModeChange(.turboOff)
sportCar1.engineMode
sportCar1.engineModeChange()
sportCar1.engineMode


final class TrunkCar : Car {
    
    let wheelCount: Int // новые свойства наследника
    let trailer: Bool // новые свойства наследника
    var trailerMode: TrailerMode // новые свойства наследника
    
    func trailerModeChange() { // метод прицепить/отцепить прицеп если он есть в наличии
        if self.trailer { // проверка на наличие прицепа
            self.trailerMode = .hook
        }
    }
    
    init(release: Int, trunk: Double, doorCount: Int, maxSpeed: Int, color: String, windowsMode: WindowsMode, wheelCount: Int, trailer: Bool, trailerMode: TrailerMode) {
        self.wheelCount = wheelCount
        self.trailer = trailer
        self.trailerMode = trailerMode
        super.init(release: release, trunk: trunk, doorCount: doorCount, maxSpeed: maxSpeed, color: color, windowsMode: windowsMode)
    }
}

var truck1 = TrunkCar(release: 1985, trunk: 3000, doorCount: 2, maxSpeed: 140, color: "Black", windowsMode: .close, wheelCount: 18, trailer: true, trailerMode: .unhook)

truck1.trailer // прицеп в наличае
truck1.trailerMode // прицеп отсоединён
truck1.trailerModeChange() // метод смены режима прицепа hook/unhook
truck1.trailerMode //прицеп присоединён
