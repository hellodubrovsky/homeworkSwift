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
    
    static var carCount: Int {get set}
    
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
    
    // Cв-во, позволяющее считать количество легковых автомобилей в авто-салоне.
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
    
    // Уникальный метод легкового автомобиля, позволяющий установить или снять тюнинг.
    func changeTunning() {
        self.tunning = self.tunning ? false : true
        print(self.tunning ? "🚙 На машину \(self.brand) \(self.model) добавлен тюнинг.\n" : "🚙 С машины \(self.brand) \(self.model) убран тюнинг.\n")
    }
}






// MARK: РАСШИРЕНИЕ КЛАССА ЛЕГКОВОГО АВТОМОБИЛЯ (Имплетация протокола - "CustomStringConvertible")

extension SportCar: CustomStringConvertible {
    var description: String {
        return "Бренд: \(brand), модель: \(model)\nТип двигателя: \(engine.rawValue)\nТип кузова: \(typeBody.rawValue)\nТип трансмиссии: \(transmission.rawValue)\nЦвет кузова: \((color.name != nil) ? color.name! : "👉 Предупреждение!Введён некорректный цвет.")\nРадио: \(radio ? "имеется" : "отсутсвует")\nПробег автомобиля: \(mileage) км.\nДвери: \(statusDoor.rawValue)\nОкна: \(statusWindow.rawValue)\nДвигатель: \(statusEngine.rawValue)\nЛюк: \(roofHatch ? "имеется" : "отсутствует")\nТюнинг: \(tunning ? "имеется" : "отсутствует")\n"
    }
}






// MARK: КЛАСС ГРУЗОВОГО АВТОМОБИЛЯ

class TruckCar: CarProtocol {
    
    // Перечисление, которое используется только для грузового авто.
    enum ActionWithTheTrunk {
        case put, remove
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
    
    // Уникальные свойства грузового автомобиля.
    let volumeTrunk: Double
    private var nowInTheTrunk: Double = 0.0
    
    // Cв-во, позволяющее считать количество грузовых автомобилей в авто-салоне.
    static var carCount: Int = 0
    
    // Деинициализатор, в нем мы считаем общее кол-во автомобилей в салоне, после продажи.
    deinit {
        print("🚚 Грузовой автомобиль \(brand) \(model) продан. В данный момент в автосалоне \(TruckCar.carCount - 1) грузовых машин.\n")
        return TruckCar.carCount -= 1
    }
    
    init(brand: String, model: String, engine: TypeEngine, transmission: TypeTransmission, color: UIColor, radio: Bool, mileage: Double, volumeTrunk: Double, nowInTheTrunk: Double, statusDoor: StatusDoorOrWindow, statusWindow: StatusDoorOrWindow, statusEngine: StatusEngine) {
        guard mileage >= 0 else { fatalError("👉 Внимание! Ошибка! Пробег не может быть меньше 0.") }
        guard volumeTrunk > 0 else { fatalError("👉 Предупреждение! Вместимость багажника не может быть меньше или равна 0.") }
        guard volumeTrunk >= nowInTheTrunk else { fatalError("👉 Предупреждение! Вы пытаетесь положить в багажник груз, вес которого превышает вместимость багажника") }
        
        self.brand = brand
        self.model = model
        self.engine = engine
        self.transmission = transmission
        self.color = color
        self.radio = radio
        self.mileage = mileage
        self.volumeTrunk = volumeTrunk
        self.nowInTheTrunk = nowInTheTrunk
        self.statusDoor = statusDoor
        self.statusWindow = statusWindow
        self.statusEngine = statusEngine
        
        // Рассчет общего числа автомобилей.
        TruckCar.carCount += 1
        print("🚚 Грузовой автомобиль \(brand) \(model) добавлен в автосалон. Теперь в автосалоне \(TruckCar.carCount) грузовых машин.\n")
    }
    
    // Уникальный метод грузового автомобиля, который позволяет положить или убрать из машины, груз определенного веса.
    func putOrRemoveFromTheTrunk(action: ActionWithTheTrunk, cargo: Double) {
        switch action {
        case .put:
            switch cargo {
            case 0:
                print("👉 Предупреждение! Вы не можете положить в багажник груз весом = 0 кг.\n")
            case ..<0:
                print("👉 Предупреждение! Вы не можете положить в багажник груз весом < 0 кг.\n")
            case 1...:
                guard (self.nowInTheTrunk + cargo) < volumeTrunk else {
                    print("👉 Предупреждение! Вы не можете положить груз весом \(cargo) кг. У вас в багажнике осталось свободного места на \(self.volumeTrunk - self.nowInTheTrunk) кг.!\n")
                    return
                }
                print("Вы положили в багажник груз весом \(cargo) кг. Сейчас в багажнике \(self.nowInTheTrunk + cargo)\n")
                self.nowInTheTrunk += cargo
            default:
                fatalError("Попало в default [put]")
            }
        case .remove:
            switch cargo {
            case 0:
                print("👉 Предупреждение! Вы не можете убрать из багажника груз весом = 0 кг.\n")
            case ..<0:
                print("👉 Предупреждение! Вы не можете убрать из багажника груз весом < 0 кг.\n")
            case 0.1...:
                guard (self.nowInTheTrunk - cargo) >= 0 else {
                    print("👉 Предупреждение! Вы не можете убрать груз весом \(cargo) кг. У вас в багажнике всего \(self.nowInTheTrunk) кг.!\n")
                    return
                }
                print("Вы убрали из багажника груз весом \(cargo) кг. Сейчас в багажнике \(self.nowInTheTrunk - cargo) кг.\n")
                self.nowInTheTrunk -= cargo
            default:
                fatalError("Попало в default [remove]")
            }
        }
    }
}






// MARK: РАСШИРЕНИЕ КЛАССА ГРУЗОВОГО АВТОМОБИЛЯ (Имплетация протокола - "CustomStringConvertible")

extension TruckCar: CustomStringConvertible {
    var description: String {
        "Бренд: \(brand), модель: \(model)\nТип двигателя: \(engine.rawValue)\nТип трансмиссии: \(transmission.rawValue)\nЦвет кузова: \((color.name != nil) ? color.name! : "👉 Предупреждение!Введён некорректный цвет.")\nРадио: \(radio ? "имеется" : "отсутсвует")\nПробег автомобиля: \(mileage) км.\nДвери: \(statusDoor.rawValue)\nОкна: \(statusWindow.rawValue)\nДвигатель: \(statusEngine.rawValue)\nКол-во вмещаемого груза: \(volumeTrunk) кг.\nСейчас груза в багажнике: \(nowInTheTrunk) кг.\n"
    }
}






// MARK: ПРИМЕРЫ ЛЕГКОВОГО АВТОМОБИЛЯ

// Проверим текущее количество легковых автомобилей в салоне.
print("Легковых машин сейчас - \(SportCar.carCount).\n")
sleep(1)

// Добавим новую легковую машину в салон.
var ferrari: SportCar? = SportCar(brand: "Ferrari", model: "F1", engine: .petrol, transmission: .auto, color: .red, radio: false, mileage: 100.0, typeBody: .sportCar, roofHatch: true, tunning: false, statusDoor: .close, statusWindow: .close, statusEngine: .stop)
sleep(1)

// Выведем о ней информацию
print(ferrari!.description)
sleep(1)

// Чтобы её продать, нужно повесить на неё тюнинг
ferrari!.changeTunning()
sleep(1)

// Покупать нашелся, нужно открыть машину и завести её.
ferrari!.changeStatusDoorAndWindow(whatToChange: .door)
sleep(1)
ferrari!.changeStatusEngine()
sleep(2)

// Пока водитель осматривает Ferrari, в салон прибыл новый автомобиль.
var tesla: SportCar? = SportCar(brand: "Tesla", model: "Cybertruck", engine: .electrical, transmission: .auto, color: .black, radio: true, mileage: 20_000.0, typeBody: .crossover, roofHatch: false, tunning: false, statusDoor: .open, statusWindow: .open, statusEngine: .start)
sleep(1)

// Выведем информацию о новом автомобиле.
print(tesla!.description)
sleep(1)

// Необходимо завести Tesla в автосалон, расстояние от места покупки до салона 7.2 км.
tesla!.driveCertainDistance(distance: 7.2)
sleep(1)

// Давайте заглушим Tesla и закроем у неё окна.
tesla!.changeStatusDoorAndWindow(whatToChange: .window)
sleep(1)
tesla!.changeStatusEngine()
sleep(1)

// Вернемся к Ferrari, покупатель довольно и забирает её.
ferrari = nil
sleep(4)






// MARK: ПРИМЕРЫ ГРУЗОВОГО АВТОМОБИЛЯ

// Проверим текущее количество грузовых автомобилей в салоне.
print("Грузовых машин сейчас - \(TruckCar.carCount).\n")
sleep(1)

// Добавим новую легковую машину в салон.
var vaz = TruckCar(brand: "VAZ", model: "K5234", engine: .diesel, transmission: .manual, color: .white, radio: false, mileage: 52_000.0, volumeTrunk: 12_000, nowInTheTrunk: 3_670, statusDoor: .close, statusWindow: .open, statusEngine: .stop)
sleep(1)

// Выведем о ней информацию.
print(vaz.description)
sleep(1)

// Попробуем положить в машину корректный груз.
 vaz.putOrRemoveFromTheTrunk(action: .put, cargo: 1_000)
 sleep(1)

 // Попробуем положить в машину груз, превышающий её грузоподъемность
 vaz.putOrRemoveFromTheTrunk(action: .put, cargo: 50_000)
 sleep(1)

 // Попробуем убрать из багажника груз, вес которого превышает текущий груз
 vaz.putOrRemoveFromTheTrunk(action: .remove, cargo: 100_000)
 sleep(1)

 // Попробуем убрать из багажника груз, вес которого превышает текущий груз
 vaz.putOrRemoveFromTheTrunk(action: .remove, cargo: 500)
 sleep(1)

 // Пора закрыть окна в машине.
 vaz.changeStatusDoorAndWindow(whatToChange: .window)
 sleep(1)
