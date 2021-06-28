import UIKit

/*
 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.*/





// MARK: Т.К. ЗАДАНИЕ ПОКАЗАЛОСЬ МНЕ НЕМНОГО СКУЧНОВАТЫМ, Я РЕШИЛ ЕГО РАЗНООБРАЗИТЬ.
// MARK: ПУСТЬ, КОЛЛЕКЦИЕЙ БУДУТ ГРУЗОВЫЕ ОТСЕКИ КОСМИЧЕСКОГО КОРАБЛЯ.
// Важно! Положив элемент с одной стороны отсека, взять его можно будет только с другой, в порядке очереди.

// Важно, чтобы у каждого элемента в отсеке, было св-во веса, поэтому необходим протокол.
protocol PresenceWeightProtocol {
    var weight: Double {get set}
}

// Т.к. отсеки будут разные, и хранить разные виды грузов, поэтому я реализую структуру с использованием джинериков.
struct HoldInRocketStruct<T: PresenceWeightProtocol> {
    private var cargoHold: [T] = []
    
    // Метод, который позволит добавить груз типа Т.
    mutating func add(cargo: T) {
        cargoHold.append(cargo)
    }
    
    // Метод, который позволит удалить последний в отсеке груз.
    mutating func remove() {
        cargoHold.removeFirst()
    }
    
    // Метод, который выводит вес всех элементов в отсеке.
    func printingWeight() {
        for i in cargoHold {
            print("Вес элемента:", i.weight, "кг.")
        }
        print()     // Необходим, для создания пробела в консоли.
    }
    
    // Метод, который выводит вес всего груза в отсеке.
    func printingAllWeight() {
        var array: [Double] = []
        for i in cargoHold {
            array.append(i.weight)
        }
        guard cargoHold.count > 0 else { fatalError("Количество элементов в вашем массиве равно 0.")}
        print("Вес всего груза в отсеке: \(array.reduce(0, +)) кг.\n")
    }
    
    // Метод, который позволяет вывести кол-во элементов
    func printingLimitedItems(limitation: Double) {
        var array: [Double] = []
        for i in cargoHold {
            array.append(i.weight)
        }
        guard cargoHold.count > 0 else { fatalError("Количество элементов в вашем массиве равно 0.")}
        print("Количество элементов, которые подходят под условие: \(array.filter{$0 <= limitation}.count)")
        print("Количество элементов, которые не подходят под условие: \(array.filter{$0 > limitation}.count)\n")
    }
    
    // Предположим, что вес элемента в космосе, будет весить в 2 раза меньше, чем на земле.
    // Для этого создадим метод, с помощью которого можно будет расчитать вес всего отсека в космосе.
    func printingWeightsOnEarthAndInSpace() {
        var array: [Double] = []
        for i in cargoHold {
            array.append(i.weight)
        }
        guard cargoHold.count > 0 else { fatalError("Количество элементов в вашем массиве равно 0.")}
        print("Вес всего отсека на земле равен: \(array.reduce(0, +)) кг.\n")
        print("Вес всего отсека в космосе будет равен: \(array.map{$0 / 2}.reduce(0, +)) кг.\n")
    }
}

// Расширение с Subscript
extension HoldInRocketStruct {
    
    subscript(index: Int) -> Double? {
        guard index >= 0 && index < cargoHold.count else { return nil }
        return cargoHold[index].weight
    }
    
    subscript(indexes: Int...) -> Double? {
        var totalWeight: Double = 0
        for index in indexes where index >= 0 && index < cargoHold.count {
            totalWeight += cargoHold[index].weight
        }
        return totalWeight
    }
}





// MARK: СОЗДАДИМ ПАРУ ОТСЕКОВ РАКЕТЫ.

// Отсек с водой.
class WaterHoldClass: PresenceWeightProtocol {
    var weight: Double
    init(weight: Double) {
        self.weight = weight
    }
}

// Отсек с едой.
class FoodHoldClass: PresenceWeightProtocol {
    var weight: Double
    init(weight: Double) {
        self.weight = weight
    }
}





// MARK: Создадим экземпляры отсеков ракеты.

var waterHold = HoldInRocketStruct<WaterHoldClass>()
var foodHold = HoldInRocketStruct<FoodHoldClass>()

// Проверим, какова сейчас загруженность отсека с пропитанием. Получим ошибку, т.к. отсек пока пустой.
//foodHold.printingAllWeight()

// Загрузим немного еды в отсек с пропитанием.
foodHold.add(cargo: FoodHoldClass(weight: 20))
foodHold.add(cargo: FoodHoldClass(weight: 30))
foodHold.add(cargo: FoodHoldClass(weight: 50))
foodHold.add(cargo: FoodHoldClass(weight: 40))

// Выведем информацию о весе нашего отсека с пропитанием. Должно быть 140 кг.
foodHold.printingAllWeight()

// Удалим первый загруженный элемент. Удаленные элемент будет первым в очереди, и будет равен 20.
foodHold.remove()

// Выведем информацию о весе каждого элемента в отсеке пропитания.
foodHold.printingWeight()

// Теперь, нам необходимо посчитать, каков вес отсека будет на земле и в космосе.
foodHold.printingWeightsOnEarthAndInSpace()

// От руководства пришло поручение, что теперь, в отсек нельзя положить предметы, вес которых более 42 кг.
// Необходима информация, сколько сейчас в отсеке подходящих и не подходящих элементов для отправки ракеты.
foodHold.printingLimitedItems(limitation: 42)

// Применим subscription
foodHold[0]
foodHold[-1, 0, 1, 4, 2]
















/*
// MARK: Замыкания (НЕ КАСАЕТСЯ ДОМАШНЕГО ЗАДАНИЯ)

// Функция проверяющая, равны числа или нет
func isEqulasFunc(itemOne: Int, itemTwo: Int) -> Bool {
    return itemOne == itemTwo
}

// Закмыкание проверяющее, равны числа или нет
let isEqalasClosure = { (itemOne: Int, itemTwo: Int) -> Bool in
    return itemOne == itemTwo
}

// Можно сократить нашу запись, добавив typealias, в котором укажем тип нашего замыкания
typealias ClosureType = (Int, Int) -> Bool

let isEqalasClosure2: ClosureType = { itemOne, itemTwo in
    return itemOne == itemTwo
}

// Можно сократить ещё.
let isEqalasClosure3: ClosureType = {
    return $0 == $1
}

// Также можно представить в таком виде.
let isEqalasClosure4: ClosureType = { $0 == $1 } */
