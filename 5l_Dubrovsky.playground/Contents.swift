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






// MARK: КЛАСС СПОРТИВНОГО АВТОМОБИЛЯ

class SportCar: CarProtocol {
    
    // Перечисление, которое используется только для легкового авто.
    enum TypeBodyCar: String {
        case sedan = "седан"
        case coupe = "купе"
        case hatchback = "хетчбэк"
        case crossover = "кроссовер"
        case sportCar = "спортивный"
    }
    
    let brand: String
    let model: String
    let engine: TypeEngine
    let transmission: TypeTransmission
    var color: UIColor
    var radio: Bool
    var mileage: Double
    var statusDoor: StatusDoorOrWindow
    var statusWindow: StatusDoorOrWindow
    var statusEngine: StatusEngine
    
    // Уникальные свойства легкового автомобиля.
    let typeBody: TypeBodyCar
    let roofHatch: Bool
    private var tunning: Bool
    
    // Cв-во, позволяющее считать количество автомобилей в авто-салоне.
    static var carCount: Int = 0
    
    // Деинициализатор, в нем мы считаем общее кол-во автомобилей в салоне, после продажи.
    deinit {
        print("🚙 Легковой автомобиль \(brand) \(model) продан. В данный момент в автосалоне \(SportCar.carCount - 1) легковых машин.\n")
        return SportCar.carCount -= 1
    }
    
    init(brand: String, model: String, engine: TypeEngine, transmission: TypeTransmission, color: UIColor, radio: Bool, mileage: Double, typeBody: TypeBodyCar, roofHatch: Bool, tunning: Bool, statusDoor: StatusDoorOrWindow, statusWindow: StatusDoorOrWindow, statusEngine: StatusEngine) {
        guard mileage >= 0 else { fatalError("👉 Внимание! Ошибка! Пробег не может быть меньше 0.") }
        self.brand = brand
        self.model = model
        self.engine = engine
        self.transmission = transmission
        self.color = color
        self.radio = radio
        self.mileage = mileage
        self.typeBody = typeBody
        self.roofHatch = roofHatch
        self.tunning = tunning
        self.statusDoor = statusDoor
        self.statusWindow = statusWindow
        self.statusEngine = statusEngine
        
        // Рассчет общего числа автомобилей.
        SportCar.carCount += 1
        print("🚙 Легковой автомобиль \(brand) \(model) добавлен в автосалон. Теперь в автосалоне \(SportCar.carCount) легковых машин.\n")
    }
    
    // Уникальные методы легкового автомобиля
    func changeTunning() {
        self.tunning = self.tunning ? false : true
        print(self.tunning ? "🚙 На машину \(self.brand) \(self.model) добавлен тюнинг.\n" : "🚙 С машины \(self.brand) \(self.model) убран тюнинг.\n")
    }
}
