import UIKit

enum EngineMode {
    case start
    case stop
    case turboOn
    case turboOff
}

enum WindowsMode {
    case open
    case close
}

enum TrailerMode {
    case unhook
    case hook
}

protocol Car: AnyObject { // AnyObject - чтобы не указывать mutating
    var release: Int { get }
    var trunk: Double { get }
    var doorCount: Int { get }
    var maxSpeed: Int { get }
    var color: String { get }
    var engineMode: EngineMode { get set }
    var windowsMode: WindowsMode { get set }
    
    func engineModeChange()
    func windowsModeChange()
}

extension Car { // методы общие для всех авто
    func engineModeChange() {
        if self.engineMode == .stop {
            self.engineMode = .start
            print("Двигатель включен")
        }
        else {
            self.self.engineMode = .stop
            print("Двигатель выключен")
        }
    }
    
    func windowsModeChange() {
        if self.windowsMode == .close {
            self.windowsMode = .open
        } else {
            self.windowsMode = .close
        }
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "\n *****************\nописание TrunkCar\n\nгод выпуска - \(release)\n объём цистерны - \(trunk)\n количество дверей - \(doorCount)\n максимальная скорость - \(maxSpeed)\n цвет - \(color)\n состояние двигателя - \(engineMode)\n состояние окон - \(windowsMode)\n количество колёс - \(wheelCount)\n наличие прицепа - \(trailer)\n состояние прицепа - \(trailerMode)"
    }
}

final class TrunkCar: Car {
    
    var release: Int
    var trunk: Double
    var doorCount: Int
    var maxSpeed: Int
    var color: String
    var engineMode: EngineMode
    var windowsMode: WindowsMode
    
    let wheelCount: Int //свойства присущие TrunkCar
    let trailer: Bool
    var trailerMode: TrailerMode
    
    init(release: Int, trunk: Double, doorCount: Int, maxSpeed: Int, color: String, engineMode: EngineMode, windowsMode: WindowsMode, wheelCount: Int, trailer: Bool, trailerMode: TrailerMode) {
        self.release = release
        self.trunk = trunk
        self.doorCount = doorCount
        self.maxSpeed = maxSpeed
        self.color = color
        self.engineMode = engineMode
        self.windowsMode = windowsMode
        self.wheelCount = wheelCount
        self.trailer = trailer
        self.trailerMode = trailerMode
    }
    
    func trailerModeChange() { // метод прицепить/отцепить прицеп если он есть в наличии
        if self.trailer { // проверка на наличие прицепа
            self.trailerMode = .hook
        }
    }
}

var truck1 = TrunkCar(release: 1985, trunk: 3000, doorCount: 2, maxSpeed: 180, color: "Red", engineMode: .stop, windowsMode: .close,  wheelCount: 18, trailer: true, trailerMode: .unhook)

truck1.windowsMode
truck1.windowsModeChange() // метод из протокола общего для всех авто
truck1.windowsMode
truck1.engineMode
truck1.engineModeChange() // метод протокола. Здесь - только смена состояния двигателя stop/start
truck1.engineMode
truck1.engineModeChange()
truck1.engineMode
truck1.trailerMode
truck1.trailerModeChange() // местный метод класса TrunkCar
truck1.trailerMode
truck1.description
print(truck1.description)

extension SportCar: CustomStringConvertible {
    var description: String {
        return "\n *****************\nописание SportCar\n \nгод выпуска - \(release)\n объём багажника - \(trunk)\n количество дверей - \(doorCount)\n максимальная скорость - \(maxSpeed)\n цвет - \(color)\n состояние двигателя - \(engineMode)\n состояние окон - \(windowsMode)\n наличие ускорителя - \(turboAccelerator)"
    }
}

final class SportCar: Car {
    
    var release: Int
    var trunk: Double
    var doorCount: Int
    var maxSpeed: Int
    var color: String
    var engineMode: EngineMode
    var windowsMode: WindowsMode
    
    let turboAccelerator: Bool // новое свойство наследника
    
    init(release: Int, trunk: Double, doorCount: Int, maxSpeed: Int, color: String, engineMode: EngineMode, windowsMode: WindowsMode, turboAccelerator: Bool) {
        self.release = release
        self.trunk = trunk
        self.doorCount = doorCount
        self.maxSpeed = maxSpeed
        self.color = color
        self.engineMode = engineMode
        self.windowsMode = windowsMode
        self.turboAccelerator = turboAccelerator
    }
    
    func engineModeChange() { // переписааный метод родителя, в который добавлены 2 состояния двигателя turboOn/turboOff
        switch self.engineMode {
        case .stop: self.engineMode = .start
        case .start: self.engineMode = .turboOn
        case .turboOn: self.engineMode = .turboOff
        case .turboOff: self.engineMode = .stop
        }
    }
}

var sportCar1 = SportCar(release: 2017, trunk: 450, doorCount: 3, maxSpeed: 230, color: "Yellow", engineMode: .stop, windowsMode: .close, turboAccelerator: true)

sportCar1.engineMode
sportCar1.engineModeChange() // изменённый метод класса SportCar в который добавлены состояния двигателя turboOn/turboOff
sportCar1.engineMode
sportCar1.engineModeChange()
sportCar1.engineMode
sportCar1.engineModeChange()
sportCar1.engineMode
sportCar1.engineModeChange()
sportCar1.engineMode
sportCar1.engineModeChange()
sportCar1.windowsMode
sportCar1.windowsModeChange() //общий метод из протокола Car
sportCar1.windowsMode
sportCar1.description
print(sportCar1.description)

