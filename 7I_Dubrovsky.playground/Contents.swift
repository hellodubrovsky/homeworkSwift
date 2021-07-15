import UIKit

/*
 
 1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
 2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch. */

/*
struct Product {
    var name: String
}

class ItemVendingMachine {
    var price: Double
    var count: UInt
    let product: Product

    init(price: Double, count: UInt, product: Product) {
        self.price = price
        self.count = count
        self.product = product
    }
}

enum VendingMachineError: Error {
    case outOfStocksError
    case invalidSelectionError
    case insifficientFundsError(coinsNeeded: Double)

    var localizedDescription: String {
        switch self {
        case .outOfStocksError:
            return "Товара по данному наименованию нет в наличии."
        case .invalidSelectionError:
            return "Товар по данному наименованию отсутсвует."
        case .insifficientFundsError(coinsNeeded: let coinsNeeded):
            return "Для платы недостаточно средств. Необходимо внести ещё: \(coinsNeeded)"
        }
    }
}

class VendingMachineClass {
    private var inventory = [
        "Chips": ItemVendingMachine(price: 20, count: 2, product: Product(name: "Chips")),
        "Chocalate": ItemVendingMachine(price: 10, count: 3, product: Product(name: "Chocalate")),
        "Water": ItemVendingMachine(price: 10, count: 0, product: Product(name: "Water"))
    ]

    func vend(itemName name: String, coinsDeposite: Double) -> (product: Product?, error: VendingMachineError?) {
        guard let item = inventory[name] else { return (product: nil, error: .invalidSelectionError) }
        guard item.price <= coinsDeposite else { return (product: nil, error: .insifficientFundsError(coinsNeeded: item.price - coinsDeposite)) }
        guard item.count > 0 else { return (product: nil, error: .outOfStocksError) }

        let surrender: Double = coinsDeposite - item.price
        print("Вы внесли: \(coinsDeposite), стоимость товара: \(item.price). Ваша сдача: \(surrender)")

        let newItem = item
        newItem.count -= 1
        inventory[name] = newItem

        return (item.product, nil)
    }
}

var vendingMachine = VendingMachineClass()
vendingMachine.vend(itemName: "Chips", coinsDeposite: 21)
vendingMachine.vend(itemName: "Chips", coinsDeposite: 20)
vendingMachine.vend(itemName: "Chips", coinsDeposite: 21) */


































// MARK: LESSON #2
// MARK: Protocol Error

// MARK: PART #1
class Factory {
    private var employess = [
        "Иванов Иван Иваныч": 10_000.0,
        "Петров Петр Петрович": 12_000.0,
        "Сидоров Сидр Сидорович": 8_000.0
    ]
    
    func salary(atFio fio: String) -> Double {
        return employess[fio] ?? 0
    }
}

let factory = Factory()
factory.salary(atFio: "Иванов Иван Иваныч")
factory.salary(atFio: "Брюс Ли Кунфигич")       // В данном случае, не ясно, такой сотрудник получил 0, или такого работника не существует.

extension Factory {
    // Минус: Если сотрудников в фабрике не будет, то программ упадёт, при попытке деления на 0.
    func averangeSalary() -> Double {
        var result = 0.0
        for (_, salary) in employess {
            result += salary
        }
        return result / Double(employess.count)
    }
    
    // Минус: Чтобы не писать if/else, в данном случае корректней использовать guard.
    func saveAverangeSalary() -> Double {
        if !employess.isEmpty {
            return averangeSalary()
        } else {
            return 0
        }
    }
    
    // Данный метод более простой для понимания.
    func correctSaveAverangeSalary() -> Double {
        guard !employess.isEmpty else { return 0 }
        return averangeSalary()
    }
}

factory.averangeSalary()
factory.saveAverangeSalary()
factory.correctSaveAverangeSalary()



// MARK: PART #2 [error]
struct Product {
    var name: String
}

struct Item {
    var count: Int
    var price: Int
    var product: Product
    
}

class VendingMachine {
    var invetory = [
        "Lays": Item(count: 2, price: 20, product: Product(name: "Lays")),
        "Water": Item(count: 3, price: 10, product: Product(name: "Water")),
        "Snickers": Item(count: 0, price: 2, product: Product(name: "Snickers"))
    ]
    
    var coinsDeposite = 5
    
    // В данном случае, при возрате nil, будет соверешенно непонятно, какая именно ошибка.
    func vend(itemName name: String) -> Product? {
        guard let item = invetory[name] else { return nil }
        guard coinsDeposite >= item.price else { return nil }
        guard item.count > 0 else { return nil }
        
        coinsDeposite -= item.price
        
        var newItem = item
        newItem.count -= 1
        invetory[name] = newItem
        
        return item.product
    }
}

var vendingMachine = VendingMachine()
vendingMachine.vend(itemName: "POP-IT")         // item nil
vendingMachine.vend(itemName: "Water")          // item nil
vendingMachine.vend(itemName: "Snickers")       // item nil

enum VendingMachineError: Error {
    case unknownItem
    case outOfStocks
    case insufficientFunds(coinsNeeded: Int)
    
    var localozedDescription: String {
        switch self {
        case .unknownItem:
            return "товара нет в ассортименте."
        case .outOfStocks:
            return "товара нет в наличии."
        case .insufficientFunds(coinsNeeded: let coinsNeeded):
            return "нехватает средств: \(coinsNeeded)"
        }
    }
}

extension VendingMachine {
    func vendWithError(itemName name: String) -> (product: Product?, error: VendingMachineError?) {
        guard let item = invetory[name] else { return (nil, .unknownItem) }
        guard coinsDeposite >= item.price else { return (nil, .insufficientFunds(coinsNeeded: item.price - coinsDeposite)) }
        guard item.count > 0 else { return (nil, .outOfStocks) }
        
        coinsDeposite -= item.price
        
        var newItem = item
        newItem.count -= 1
        invetory[name] = newItem
        
        return (item.product, nil)
    }
}

let saleOne = vendingMachine.vendWithError(itemName: "POP-IT")
if let product = saleOne.product {
    print("Покупка прошла успешно! Получите: \(product.name)")
} else if let error = saleOne.error {
    print("Произошла ошибка: \(error.localozedDescription)")
}

// vendingMachine.coinsDeposite = 50
let saleTwo = vendingMachine.vendWithError(itemName: "Water")
if let product = saleTwo.product {
    print("Покупка прошла успешно! Получите: \(product.name)")
} else if let error = saleTwo.error {
    print("Произошла ошибка: \(error.localozedDescription)")
}

let saleThree = vendingMachine.vendWithError(itemName: "Snickers")
if let product = saleThree.product {
    print("Покупка прошла успешно! Получите: \(product.name)")
} else if let error = saleThree.error {
    print("Произошла ошибка: \(error.localozedDescription)\n")
}



// MARK: PART #3 [try/catch]
extension VendingMachine {
    
    // В данном случае, при использовании trows, мы можем быть точно уверены, что вернется какой-то продукт, или мы выкинем исключение.
    // Исключение выбрасывается в guard, с помощью команды throw. В данном случае, мы выбрасываем конкретную ошибку.
    
    func vendWithTrowError(itemName name: String) throws -> Product {
        guard let item = invetory[name] else { throw VendingMachineError.unknownItem }
        guard coinsDeposite >= item.price else { throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposite) }
        guard item.count > 0 else { throw VendingMachineError.outOfStocks }
        
        coinsDeposite -= item.price
        
        var newItem = item
        newItem.count -= 1
        invetory[name] = newItem
        
        return item.product
    }
}

// Необходимо, использовать ключевое слово try, чтобы было понятно, что данное свойство может выбрасить исключение.
do {
    // В данном блоке, происходит реализация так, если исключений вообще нет.
    let product = try vendingMachine.vendWithTrowError(itemName: "POP-IT")
    print("Покупка прошла успешно. Получите: \(product.name)")
    
} catch {
    // В данный блок попадаем тогда, когда ловим исключение.
    if let error = error as? VendingMachineError {
        // Если ошибка, существует в перечислении VendingMachineError, то вывыдим её св-во localizedDescription.
        print("Произошла ошибка:", error.localozedDescription, "\n")
    } else {
        // Если такой ошибки нет в VendingMachineError, то выводим ошибку из протокола Error.
        print("Произошла непредвиденная ошибка:", error.localizedDescription)
    }

    /*
    } catch VendingMachineError.unknownItem {
        print("Произошла ошибка: товара нет в ассортименте")
    } catch VendingMachineError.outOfStocks {
        print("Произошла ошибка: товара нет в наличии.")
    } catch VendingMachineError.insufficientFunds(coinsNeeded: let coinsNeeded){
        print("Произошла ошибка: нехватает средств: \(coinsNeeded)")
    } catch {
        print("Произошла непредвиденная ошибка:", error.localizedDescription)
    }
    */
}


// MARK: PART #4

enum buyError: Error {
    case buyerNotFound
}

let favoriteSnake = [
    "Alice": "Lays",
    "Bob": "Water",
    "Eve": "Twix"
]

func buyFavoriteSnake(person: String, vendingMachine: VendingMachine) throws -> Product {
    guard let snakeName = favoriteSnake[person] else { throw buyError.buyerNotFound }
    return try vendingMachine.vendWithTrowError(itemName: snakeName)
}

do {
    let productFavorite = try buyFavoriteSnake(person: "Alice", vendingMachine: vendingMachine)
    print("Alice купила \(productFavorite.name)")
} catch {
    if let error = error as? VendingMachineError {
        print("Произошла ошибка:", error.localozedDescription, "\n")
    } else {
        print("Покупатель не найден")
    }
}

// Если try использовать с знаком вопроса (try?) то блоки do/catch использовать необязательно.
// При использовании try?, приложение либо вернет конкретный продукт, либо вернёт nil, если поймает исключение.
if let productFavorite2 = try? buyFavoriteSnake(person: "Eve", vendingMachine: vendingMachine) {
    print("Eve купила \(productFavorite2.name)")
} else {
    print("Купи что-то другое.\n")
}

//let productFavorite2 = try! buyFavoriteSnake(person: "Eve", vendingMachine: vendingMachine)
//print("Eve купила \(productFavorite2.name)")



// MARK: PART #5
let urlOne = URL(string: "https://google.com")
let urlTwo = URL(string: "https://google.com>$#%#%#%")



// MARK: PART #6
enum SomeError: Error {
    case notNumber
}

func numberFrom(string: String) throws -> Int {
    guard let value = Int(string) else { throw SomeError.notNumber }
    return value
}

let array = ["1", "2", "3", "4", "5"]
let resultOne: [Int] = array.map { return Int($0) ?? 0 }
let resultTwo: [Int]? = try? array.map { try numberFrom(string: $0)}
let resultThree: [Int] = try array.map { string throws -> Int in
    guard let value =  Int(string) else { throw SomeError.notNumber }
    return value
}

print("Array string:", array)
print("Result one:", resultOne)
//print("Result two:", resultTwo)
print("Result three:", resultThree)
