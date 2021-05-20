import UIKit

/*
1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова,
   запущен ли двигатель, открыты ли окна, заполненный объем багажника.
3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель,
   открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
4. Добавить в структуры метод с одним аргументом типа перечисления, который будет
   менять свойства структуры в зависимости от действия.
5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
6. Вывести значения свойств экземпляров в консоль. */



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





// MARK: СТРУКТУРА ЛЕГКОВОГО АВТОМОБИЛЯ
struct SportCar {
    
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
    var color: UIColor
    let typeBody: TypeBodyCar
    let engine: TypeEngine
    let transmission: TypeTransmission
    var radio: Bool
    // Некоторые свойства специально попробовал сделать private, чтобы изменить можно быть только с помощью методов.
    private var statusWindow: StatusDoorOrWindow
    private var statusDoor: StatusDoorOrWindow
    
    private var statusEngine: StatusEngine {
        willSet {
            print("Статус двигателя будет измен. Сейчас двигатель \(statusEngine.rawValue), а будет \(newValue.rawValue).\n")
        }
    }
    
    // Данная переменная обозначает пробег автомобиля. Ниже описан метод, с помощью которого, можно прокатиться на машине.
    private var mileage: Double {
        didSet {
            guard oldValue != mileage else { return }
            print("Вы проехали \(mileage - oldValue) км. Пробег был \(oldValue) км. Пробег стал \(mileage) км.\n")
        }
    }
    
    // Вывод всех значение, произовдится через св-во description.
    var description: String {
        return "Ваш автомобиль \(brand) \(model).\nЦвет: \((color.name != nil) ? color.name! : "ПРЕДУПРЕЖДЕНИЕ!ВВЕДЁН НЕКОРРЕКТНЫЙ ЦВЕТ!")\nТип кузова: \(typeBody.rawValue)\nТип двигателя: \(engine.rawValue)\nТрансмиссия: \(transmission.rawValue)\nРадио \(radio ? "имеется" : "отсутсвует")\nПробег: \(mileage) км.\nОкна сейчас \(statusWindow.rawValue)\nДвери сейчас \(statusDoor.rawValue)\nДвигатель сейчас \(statusEngine.rawValue)\n"
    }
    
    init(brand: String, model: String, color: UIColor, typeBody: TypeBodyCar, engine: TypeEngine, transmission: TypeTransmission, radio: Bool, sWindow: StatusDoorOrWindow, sEnjine: StatusEngine, sDoor: StatusDoorOrWindow, mileage: Double = 0.0) {
        guard mileage >= 0 else { fatalError("Внимание! Ошибка! Пробег не может быть меньше 0.") }
        
        self.brand = brand
        self.model = model
        self.color = color
        self.typeBody = typeBody
        self.engine = engine
        self.transmission = transmission
        self.radio = radio
        statusWindow = sWindow
        statusEngine = sEnjine
        statusDoor = sDoor
        self.mileage = mileage
    }
    
    // Метод, позволяющий проехать на машине, любое расстояние в км.
    mutating func goByCar(drive: Double) -> Double {
        guard drive > 0 else {
            print("ПРЕДУПРЕЖДЕНИЕ!ВВЕДЕНО НЕКОРРЕКТНОЕ РАССТОЯНИЕ = \(drive) км.! РАССТОЯНИЯ ДОЛЖНО БЫТЬ > 0\n")
            return self.mileage
            
        }
        self.mileage += drive
        return self.mileage
        
    }
    
    // Метод позволяющий изменить состояние дверей или окон.
    mutating func changeStatusDoorAndWindow(whatToChange: ChoiceOfDoorsAndWindows) {
        switch whatToChange {
        case .door:
            if self.statusDoor == .close {
                self.statusDoor = .open
            } else {
                self.statusDoor = .close
            }
            print("Стутус дверей изменился, теперь они: \(self.statusDoor.rawValue).\n")
        case .window:
            if self.statusWindow == .close {
                self.statusWindow = .open
            } else {
                self.statusWindow = .close
            }
            print("Стутус окон изменился, теперь они: \(self.statusWindow.rawValue).\n")
        }
    }
    
    // Метод позволяющий завести или заглушить двигатель.
    mutating func changeStatusEngine() {
        if self.statusEngine == .stop {
            self.statusEngine = .start
        } else {
            self.statusEngine = .stop
        }
    }
}


// MARK: ПРИМЕРЫ ЛЕГКОВОГО АВТОМОБИЛЯ
/*
var ferrari = SportCar(brand: "Ferrari", model: "F1", color: .purple, typeBody: .sportCar, engine: .petrol, transmission: .auto, radio: true, sWindow: .close, sEnjine: .stop, sDoor: .close)
print(ferrari.description)
ferrari.goByCar(drive: 0)
ferrari.goByCar(drive: 30.0)
ferrari.goByCar(drive: -50.0)
ferrari.goByCar(drive: 100.0)

ferrari.changeStatusEngine()
ferrari.changeStatusDoorAndWindow(whatToChange: .door)

ferrari.color = .red
print(ferrari.description)
*/





// MARK: СТРУКТУРА ГРУЗОВОГО АВТОМОБИЛЯ
struct TrunkCar {
    
    // Перечисление, которое используется только для грузового авто.
    enum ActionWithTheTrunk {
        case put, remove
    }
    
    let brand: String
    let model: String
    let color: UIColor
    let engine: TypeEngine
    let transmission: TypeTransmission
    let radio: Bool
    let volumeTrunk: Double
    private var nowInTheTrunk: Double = 0.0
    private var statusWindow: StatusDoorOrWindow
    private var statusEngine: StatusEngine
    private var statusDoor: StatusDoorOrWindow
    
    private var mileage: Double {
        didSet {
            guard oldValue != mileage else { return }
            print("Вы проехали \(mileage - oldValue) км. Пробег был \(oldValue) км. Пробег стал \(mileage) км.\n")
        }
    }
    
    var description: String {
        return "Ваш автомобиль \(brand) \(model).\nЦвет: \((color.name != nil) ? color.name! : "ПРЕДУПРЕЖДЕНИЕ!ВВЕДЁН НЕКОРРЕКТНЫЙ ЦВЕТ!")\nТип двигателя: \(engine.rawValue)\nТрансмиссия: \(transmission.rawValue)\nРадио \(radio ? "имеется" : "отсутсвует")\nВместимость багажника: \(volumeTrunk) кг.\nСейчас в багажнике: \(nowInTheTrunk) кг.\nПробег: \(mileage) км.\nОкна сейчас \(statusWindow.rawValue)\nДвери сейчас \(statusDoor.rawValue)\nДвигатель сейчас \(statusEngine.rawValue)\n"
    }
    
    init(brand: String, model: String, color: UIColor, engine: TypeEngine, transmission: TypeTransmission, radio: Bool, volumeTrunk: Double, nowInTheTrunk: Double, sWindow: StatusDoorOrWindow, sEnjine: StatusEngine, sDoor: StatusDoorOrWindow, mileage: Double = 0.0) {
        guard mileage >= 0 else { fatalError("Внимание! Ошибка! Пробег не может быть меньше 0.") }
        guard volumeTrunk > 0 else { fatalError("Внимание! Ошибка! Вместимость багажника не может быть меньше или равна 0.") }
        guard volumeTrunk >= nowInTheTrunk else { fatalError("Внимание! Ошибка! Вы пытаетесь положить в багажник груз, вес которого превышает вместимость багажника") }
        
        self.brand = brand
        self.model = model
        self.color = color
        self.engine = engine
        self.transmission = transmission
        self.radio = radio
        self.volumeTrunk = volumeTrunk
        self.nowInTheTrunk = nowInTheTrunk
        statusWindow = sWindow
        statusEngine = sEnjine
        statusDoor = sDoor
        self.mileage = mileage
    }
    
    mutating func goByCar(drive: Double) -> Double {
        guard drive > 0 else {
            print("ПРЕДУПРЕЖДЕНИЕ!ВВЕДЕНО НЕКОРРЕКТНОЕ РАССТОЯНИЕ = \(drive) км.! РАССТОЯНИЯ ДОЛЖНО БЫТЬ > 0\n")
            return self.mileage
            
        }
        self.mileage += drive
        return self.mileage
    }
    
    mutating func changeStatusDoorAndWindow(whatToChange: ChoiceOfDoorsAndWindows) {
        switch whatToChange {
        case .door:
            if self.statusDoor == .close {
                self.statusDoor = .open
            } else {
                self.statusDoor = .close
            }
            print("Стутус дверей изменился, теперь они: \(self.statusDoor.rawValue).\n")
        case .window:
            if self.statusWindow == .close {
                self.statusWindow = .open
            } else {
                self.statusWindow = .close
            }
            print("Стутус окон изменился, теперь они: \(self.statusWindow.rawValue).\n")
        }
    }
    
    mutating func changeStatusEngine() {
        if self.statusEngine == .stop {
            self.statusEngine = .start
        } else {
            self.statusEngine = .stop
        }
    }
    
    // Метод, который позволяет положить или убрать из машины, груз определенного веса.
    mutating func putOrRemoveFromTheTrunk(action: ActionWithTheTrunk, cargo: Double) {
        switch action {
        case .put:
            switch cargo {
            case 0:
                print("Вы не можете положить в багажник груз весом = 0 кг.\n")
            case ..<0:
                print("Вы не можете положить в багажник груз весом < 0 кг.\n")
            case 1...:
                guard (self.nowInTheTrunk + cargo) < volumeTrunk else {
                    print("Вы не можете положить груз весом \(cargo) кг. У вас в багажнике осталось свободного места на \(self.volumeTrunk - self.nowInTheTrunk) кг.!\n")
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
                print("Вы не можете убрать из багажника груз весом = 0 кг.\n")
            case ..<0:
                print("Вы не можете убрать из багажника груз весом < 0 кг.\n")
            case 0.1...:
                guard (self.nowInTheTrunk - cargo) >= 0 else {
                    print("Вы не можете убрать груз весом \(cargo) кг. У вас в багажнике всего \(self.nowInTheTrunk) кг.!\n")
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



// MARK: ПРИМЕРЫ ГРУЗОВОГО АВТОМОБИЛЯ
/*
var kamaz = TrunkCar(brand: "MAZ", model: "K2", color: .darkGray, engine: .diesel, transmission: .manual, radio: false, volumeTrunk: 100, nowInTheTrunk: 10, sWindow: .close, sEnjine: .stop, sDoor: .open)
print(kamaz.description)

// Пробуем положить доступный груз.
kamaz.putOrRemoveFromTheTrunk(action: .put, cargo: 20)

// Пробуем положить груз, превышающий его вместимость.
kamaz.putOrRemoveFromTheTrunk(action: .put, cargo: 80)

// Пробуем убрать доступный груз.
kamaz.putOrRemoveFromTheTrunk(action: .remove, cargo: 5)

// Пробуем убрать груз, превыщающий уже имеющийся в багажнике.
kamaz.putOrRemoveFromTheTrunk(action: .remove, cargo: 50)

kamaz.goByCar(drive: 20)
kamaz.changeStatusEngine()
kamaz.changeStatusDoorAndWindow(whatToChange: .door)

// Выводим все данные о грузовом авто в консоль.
print(kamaz.description)
*/
