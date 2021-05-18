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

//enum CarStatusTrunk: String {
//    case full = "Полный"
//    case almostFull = "Почти полный"
//    case halfFull = "Заполнен на половину"
//    case lessThanHalf = "Меньше половины = от 25 до 49"
//    case few = "Мало от 0 до 24"
//    case empty = "Пустой = 0"
//    case noTrunk = "Багажник отсутсвует"
//}

extension UIColor {
    var name: String? {
        switch self {
        case UIColor.black: return "black"
        case UIColor.darkGray: return "darkGray"
        case UIColor.lightGray: return "lightGray"
        case UIColor.white: return "white"
        case UIColor.gray: return "gray"
        case UIColor.red: return "red"
        case UIColor.green: return "green"
        case UIColor.blue: return "blue"
        case UIColor.cyan: return "cyan"
        case UIColor.yellow: return "yellow"
        case UIColor.magenta: return "magenta"
        case UIColor.orange: return "orange"
        case UIColor.purple: return "purple"
        case UIColor.brown: return "brown"
        default: return nil
        }
    }
}



// MARK: Структура легкового автомобиля
struct SportCar {
    let brand: String
    let model: String
    let color: UIColor
    let typeBody: TypeBodyCar
    let engine: TypeEngine
    let transmission: TypeTransmission
    var radio: Bool
    let volumeTrunk: Double
    var nowInTheTrunk: Double = 0.0
    
    private var mileage: Double = 0.0
    private var statusDoor: StatusDoorOrWindow
    private var statusWindow: StatusDoorOrWindow
    private var statusEngine: StatusEngine
    
    init(brand: String, model: String, color: UIColor, typeBody: TypeBodyCar, engine: TypeEngine, transmission: TypeTransmission, radio: Bool, volumeTrunk: Double, nowInTheTrunk: Double, mileage: Double, sDoor: StatusDoorOrWindow, sWindow: StatusDoorOrWindow, sEnjine: StatusEngine) {
        self.brand = brand
        self.model = model
        self.color = color
        self.typeBody = typeBody
        self.engine = engine
        self.transmission = transmission
        self.radio = radio
        self.volumeTrunk = volumeTrunk
        self.nowInTheTrunk = nowInTheTrunk
        self.mileage = mileage
        statusDoor = sDoor
        statusWindow = sWindow
        statusEngine = sEnjine
    }
}

