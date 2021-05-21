import UIKit

// MARK: ДОМАШНЕЕ ЗАДАНИЕ
/*  1. Описать класс Car c общими свойствами автомобилей и пустым
       методом действия по аналогии с прошлым заданием.
    2. Описать пару его наследников trunkCar и sportСar. Подумать,
       какими отличительными свойствами обладают эти автомобили. Описать
       в каждом наследнике специфичные для него свойства.
    3. Взять из прошлого урока enum с действиями над автомобилем. Подумать,
       какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
    4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
    5. Создать несколько объектов каждого класса. Применить к ним различные действия.
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

// Перечисление, необходимое для функции printSpecificInfoAboutCar.
enum DisplayedAmountOfInformationAboutTheMachine {
    case full       // Выводится полная информация.
    case middle     // Выводится все, кроме статусов различных деталей.
    case short      // Выводится только информация о бренде, модели, двигателе и типе трансмиссии (для легковой машины и тип кузова).
}

// Перечисление, которое используется только для легкового авто.
enum TypeBodyCar: String {
    case sedan = "седан"
    case coupe = "купе"
    case hatchback = "хетчбэк"
    case crossover = "кроссовер"
    case sportCar = "спортивный"
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



// MARK: РОДИТЕЛЬСКИЙ КЛАСС "CAR"
class Car {
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
    
    // Статичный метод высчитавающий кол-во созданных машин.
    static var countCar: Int = 0
    
    init(brand: String, model: String, engine: TypeEngine, transmission: TypeTransmission, color: UIColor, radio: Bool, mileage: Double, statusDoor: StatusDoorOrWindow, statusWindow: StatusDoorOrWindow, statusEngine: StatusEngine) {
        guard mileage >= 0 else { fatalError("Внимание! Ошибка! Пробег не может быть меньше 0.") }
        self.brand = brand
        self.model = model
        self.engine = engine
        self.transmission = transmission
        self.color = color
        self.radio = radio
        self.mileage = mileage
        self.statusDoor = statusDoor
        self.statusWindow = statusWindow
        self.statusEngine = statusEngine
        
        // Прибавляем единицу, после каждой новой машины.
        Car.countCar += 1
    }
    
    deinit {
        // Отнимаем единицу, после каждой удаленной машины.
        return Car.countCar -= 1
    }
    
    // Метод позволяющий завести или заглушить двигатель.
    // Создал в родительском классе, т.к. его могут использовать все машины.
    func changeStatusEngine() {
        self.statusEngine = self.statusEngine == .stop ? .start : .stop
        print(self.statusEngine == .stop ? "🚙 Двигатель \(self.brand) \(self.model) заглушён.\n" : "🚙 Двигатель \(self.brand) \(self.model) заведён.\n")
    }
    
    // Метод позволяющий изменить состояние дверей или окон.
    // Создал в родительском классе, т.к. его могут использовать все машины.
    func changeStatusDoorAndWindow(whatToChange: ChoiceOfDoorsAndWindows) {
        switch whatToChange {
        case .door:
            self.statusDoor = self.statusDoor == .open ? .close : .open
            print("Стутус дверей изменился, теперь они: \(self.statusDoor.rawValue).\n")
        case .window:
            self.statusWindow = self.statusWindow == .open ? .close : .open
            print("Стутус окон изменился, теперь они: \(self.statusWindow.rawValue).\n")
        }
    }
    
    // Метод, с помощью которого можно проехать определенную дистанцию на автомобиле.
    // Создал в родительском классе, т.к. его могут использовать все машины.
    func driveCertainDistance(distance: Double) -> Double {
        guard distance > 0 else {
            print("👉 Предупреждение! Автомобиль не поехал, т.к. он не может проехать нулевую или отрицательную дистанцию.\n")
            return self.mileage
        }
        self.mileage += distance
        print("🚙 Автомобиль проехал \(distance) км., в данный момент пробег состовляет \(self.mileage) км.\n")
        return self.mileage
    }
    
    // Пустой метод класса, который может выводить как полную, так и сокращенную информацию об автомобиле.
    func printSpecificInfoAboutCar(amountOfInformation: DisplayedAmountOfInformationAboutTheMachine) {}
}



// MARK: ПОДКЛАСС ЛЕГКОВОГО АВТОМОБИЛЯ
class SportCar: Car {
    let roofHatch: Bool
    let typeBody: TypeBodyCar
    private var tunning: Bool
    
    init(brand: String, model: String, engine: TypeEngine, transmission: TypeTransmission, color: UIColor, radio: Bool, mileage: Double, statusDoor: StatusDoorOrWindow, statusWindow: StatusDoorOrWindow, statusEngine: StatusEngine, roofHatch: Bool, typeBody: TypeBodyCar, tunning: Bool) {
        self.roofHatch = roofHatch
        self.typeBody = typeBody
        self.tunning = tunning
        super.init(brand: brand, model: model, engine: engine, transmission: transmission, color: color, radio: radio, mileage: mileage, statusDoor: statusDoor, statusWindow: statusWindow, statusEngine: statusEngine)
    }
    
    // Метод позволяющий установить или снять тюнинг.
    func changeTunning() {
        self.tunning = self.tunning ? false : true
        print(self.tunning ? "🚙 На машину \(self.brand) \(self.model) добавлен тюнинг.\n" : "🚙 С машины \(self.brand) \(self.model) убран тюнинг.\n")
    }
    
    // Дополненный метод родительского класса, позволяющий выводить полную информацию об автомобиле.
    override func printSpecificInfoAboutCar(amountOfInformation: DisplayedAmountOfInformationAboutTheMachine) {
        switch amountOfInformation {
        case .short:
            print("Бренд: \(brand), модель: \(model)\nТип двигателя: \(engine.rawValue)\nТип кузова: \(typeBody.rawValue)\nТип трансмиссии: \(transmission.rawValue)\n")
        case .middle:
            print("Бренд: \(brand), модель: \(model)\nТип двигателя: \(engine.rawValue)\nТип кузова: \(typeBody.rawValue)\nТип трансмиссии: \(transmission.rawValue)\nЦвет кузова: \((color.name != nil) ? color.name! : "👉 Предупреждение!Введён некорректный цвет.")\nРадио: \(radio ? "имеется" : "отсутсвует")\nПробег автомобиля: \(mileage) км.\nЛюк: \(roofHatch ? "имеется" : "отсутствует")\nТюнинг: \(tunning ? "имеется" : "отсутствует")\n")
        case .full:
            print("Бренд: \(brand), модель: \(model)\nТип двигателя: \(engine.rawValue)\nТип кузова: \(typeBody.rawValue)\nТип трансмиссии: \(transmission.rawValue)\nЦвет кузова: \((color.name != nil) ? color.name! : "👉 Предупреждение!Введён некорректный цвет.")\nРадио: \(radio ? "имеется" : "отсутсвует")\nПробег автомобиля: \(mileage) км.\nДвери: \(statusDoor.rawValue)\nОкна: \(statusWindow.rawValue)\nДвигатель: \(statusEngine.rawValue)\nЛюк: \(roofHatch ? "имеется" : "отсутствует")\nТюнинг: \(tunning ? "имеется" : "отсутствует")\n")
        }
    }
}
