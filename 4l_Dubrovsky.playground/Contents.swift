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
    }
    
    // Пустые методы, изменения статуса двигателя, дверей и окон.
    func changeStatusEngine() {}
    func changeStatusDoorAndWindow(whatToChange: ChoiceOfDoorsAndWindows) {}
    
    // Метод, с помощью которого можно проехать определенную дистанцию на автомобиле.
    func driveCertainDistance(distance: Double) -> Double {
        guard distance > 0 else {
            print("👉 Предупреждение! Автомобиль не поехал, т.к. он не может проехать нулевую или отрицательную дистанцию.")
            return self.mileage
        }
        self.mileage += distance
        print("🚙 Автомобиль проехал \(distance) км., в данный момент пробег состовляет \(self.mileage) км.")
        return self.mileage
    }
}


