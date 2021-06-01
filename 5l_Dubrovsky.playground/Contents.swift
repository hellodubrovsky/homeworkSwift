import UIKit

/*
 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с
 автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу
 на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства,
 отличающиеся для спортивного автомобиля и цистерны.
 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 6. Вывести сами объекты в консоль. */






// MARK: НЕОБХОДИМЫЕ ПЕРЕЧИСЛЕНИЯ

enum ChoiceOfDoorsAndWindows {
    case door, window
}

enum StatusDoorOrWindow: String {
    case open = "открыты"
    case close = "закрыты"
}

enum StatusEngine: String {
    case start = "заведен"
    case stop = "заглушен"
}

enum TypeEngine: String {
    case petrol = "бензиновый"
    case diesel = "дизельный"
    case electrical = "электрический"
    case gas = "газовый"
}

enum TypeTransmission: String {
    case manual = "ручная"
    case auto = "автоматическая"
}

extension UIColor {
    var name: String? {
        switch self {
        case UIColor.black: return "черный"
        case UIColor.darkGray: return "темно-серый"
        case UIColor.lightGray: return "светло-серый"
        case UIColor.white: return "белый"
        case UIColor.gray: return "серый"
        case UIColor.red: return "красный"
        case UIColor.green: return "зеленый"
        case UIColor.blue: return "голубой"
        case UIColor.yellow: return "желтый"
        case UIColor.orange: return "оранжевый"
        case UIColor.brown: return "серый"
        case UIColor.red: return "красный"
        default: return nil
        }
    }
}






// MARK: ПРОТОКОЛ АВТОМОБИЛЯ

protocol CarProtocol: AnyObject {
    var brand: String {get}
    var model: String {get}
    var engine: TypeEngine {get}
    var transmission: TypeTransmission {get}
    
    var color: UIColor {get set}
    var radio: Bool {get set}
    var mileage: Double {get set}
    var statusDoor: StatusDoorOrWindow {get set}
    var statusWindow: StatusDoorOrWindow {get set}
    var statusEngine: StatusEngine {get set}
    
    func changeStatusEngine()
    func changeStatusDoorAndWindow(whatToChange: ChoiceOfDoorsAndWindows)
    func driveCertainDistance(distance: Double) -> Double
}






// MARK: РАСШИРЕНИЕ ПРОТОКОЛА CAR

extension CarProtocol {
    
    // Метод позволяющий завести или заглушить двигатель.
    func changeStatusEngine() {
        self.statusEngine = self.statusEngine == .stop ? .start : .stop
        print(self.statusEngine == .stop ? "🚙 Двигатель \(self.brand) \(self.model) заглушён.\n" : "🚙 Двигатель \(self.brand) \(self.model) заведён.\n")
    }
    
    // Метод позволяющий изменить состояние дверей или окон.
    func changeStatusDoorAndWindow(whatToChange: ChoiceOfDoorsAndWindows) {
        switch whatToChange {
        case .door:
            self.statusDoor = self.statusDoor == .open ? .close : .open
            print("🚙 Стутус дверей изменился, теперь они: \(self.statusDoor.rawValue).\n")
        case .window:
            self.statusWindow = self.statusWindow == .open ? .close : .open
            print("🚙 Стутус окон изменился, теперь они: \(self.statusWindow.rawValue).\n")
        }
    }
    
    // Метод позволяющий изменить состояние дверей или окон.
    func driveCertainDistance(distance: Double) -> Double {
        guard distance > 0 else {
            print("👉 Предупреждение! Автомобиль не поехал, т.к. он не может проехать нулевую или отрицательную дистанцию.\n")
            return self.mileage
        }
        self.mileage += distance
        print("🚙 Автомобиль проехал \(distance) км., в данный момент пробег состовляет \(self.mileage) км.\n")
        return self.mileage
    }
}
