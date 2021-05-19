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



// MARK: Необходимые перечисления
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

enum TypeBodyCar: String {
    case sedan = "седан"
    case coupe = "купе"
    case hatchback = "хетчбэк"
    case crossover = "кроссовер"
    case sportCar = "спортивный"
}

enum ActionWithTheTrunk {
    case put, remove
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



// MARK: Структура легкового автомобиля
struct SportCar {
    let brand: String
    let model: String
    var color: UIColor
    let typeBody: TypeBodyCar
    let engine: TypeEngine
    let transmission: TypeTransmission
    var radio: Bool
    private var statusWindow: StatusDoorOrWindow
    private var statusEngine: StatusEngine
    
    private var statusDoor: StatusDoorOrWindow {
        willSet {
            print("Статус дверей будет измен. Сейчас двери \(statusDoor), а будут \(newValue).\n")
        }
    }
    
    private var mileage: Double {
        didSet {
            guard oldValue != mileage else { return }
            print("Вы проехали \(mileage - oldValue) км. Пробег был \(oldValue) км. Пробег стал \(mileage) км.\n")
        }
    }
    
    var description: String {
        return "Ваш автомобиль \(brand) \(model).\nЦвет: \((color.name != nil) ? color.name! : "ПРЕДУПРЕЖДЕНИЕ!ВВЕДЁН НЕКОРРЕКТНЫЙ ЦВЕТ!")\nТип кузова: \(typeBody.rawValue)\nТип двигателя: \(engine.rawValue)\nТрансмиссия: \(transmission.rawValue)\nРадио \(radio ? "имеется" : "отсутсвует")\nПробег: \(mileage) км.\nОкна сейчас \(statusWindow.rawValue)\nДвери сейчас \(statusDoor.rawValue)\nДвигатель сейчас \(statusEngine.rawValue)\n"
    }
    
    init(brand: String, model: String, color: UIColor, typeBody: TypeBodyCar, engine: TypeEngine, transmission: TypeTransmission, radio: Bool, sWindow: StatusDoorOrWindow, sEnjine: StatusEngine, sDoor: StatusDoorOrWindow, mileage: Double = 0.0) {
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
            print("Стутус дверей изменился, теперь они: \(self.statusDoor).\n")
        case .window:
            if self.statusWindow == .close {
                self.statusWindow = .open
            } else {
                self.statusWindow = .close
            }
            print("Стутус окон изменился, теперь они: \(self.statusWindow).\n")
        }
    }
    
    mutating func changeStatusEngine() {
        if self.statusEngine == .stop {
            self.statusEngine = .start
        } else {
            self.statusEngine = .stop
        }
    }
}

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

// Типы для грузового авто
//    let volumeTrunk: Double
//    var nowInTheTrunk: Double = 0.0
