import UIKit

/*
 
 1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
 2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch. */






// MARK: - Необходимые перечисления.

enum PaymentSystems {
    case mastercard
    case maestro
    case visa
}

enum AtmStatus {
    case turnOn
    case turnOff
}

enum CardsStatus {
    case active
    case blocked
}

enum OperationATM {
    case addMoney
    case withdrawMoney
}







// MARK: - Структура банковской карты.

struct BankCard {
    let nameOfCardHolder: String
    let paymentSystem: PaymentSystems
    let pinCode: UInt //= UInt.random(in: 1000...9999)
    var cardStatus: CardsStatus = .active
    private(set) var amountOfMoney: Int
    
    // Актуализация баланса на карте.
    mutating func setAmountOfMoney(_ value: Int) {
        self.amountOfMoney = value
    }
}







// MARK: - Расширение с ошибками.

enum CashMachineError: Error {
    
    // Ошибки кассиров.
    case invalidSecretKey
    case zeroDeposite
    case maximumCapacityExceeded(exceedsBy: Int)
    case minimumCapacityExceeded(exceedsBy: Int)
    case cashMachineIsOff
    
    // Ошибки пользователей.
    case invalidPaymentSystem
    case invalidPinCode
    case cardInBlock
    case excessOfBalance
    
    var localozedDescription: String {
        switch self {
        case .invalidSecretKey:
            return "Ошибка операции: Введён не верный секретный ключ.\n"
        case .zeroDeposite:
            return "Ошибка операции: Внесённый депозит не может быть меньше или равен нулю.\n"
        case .cashMachineIsOff:
            return "Операции невозможны: Банкомат выключен.\n"
        case .invalidPaymentSystem:
            return "Ошибка операции: Данный банкомат, не поддерживает платежную систему вашей карты.\n"
        case .invalidPinCode:
            return "Ошибка операции: Вы ввели некорректный пин-код.\n"
        case .cardInBlock:
            return "Ошибка операции: Ваша карта заблокирована.\n"
        case .excessOfBalance:
            return "Ошибка операции: Вы ввели сумму для снятия, превыющую баланс вашей карты.\n"
        case .maximumCapacityExceeded(exceedsBy: let sum):
            return "Ошибка операции: Сумма средств в банкомате превышает его максимальную вместимость, в данный момент можно положить \(sum) руб.\n"
        case .minimumCapacityExceeded(exceedsBy: let sum):
            return "Ошибка операции: Данный банкомат не может выдать заданную сумму. Максимально возможная выдача средств составляет \(sum) руб.\n"
        }
    }
}







// MARK: - Класс банкомата (каркас).

class ATM {
    private let idCashMachine: String
    private let paymentSystem: [PaymentSystems]
    private let maximumMoneyCapacity: Int
    private var minimumMoneyCapacity: Int
    private var secretKey: String
    private var amountOfMoney: Int
    private var atmStatus: AtmStatus = .turnOff
    
    init(idCashMachine: String, paymentSystem: [PaymentSystems], maximumMoneyCapacity: Int, minimumMoneyCapacity: Int, secretKey: String, amountOfMoney: Int) {
        guard amountOfMoney > 0 && minimumMoneyCapacity > 0 && maximumMoneyCapacity >= 0 else { fatalError("Что-то меньше 0.") }
        guard amountOfMoney >= minimumMoneyCapacity else { fatalError("Ошибка. Создание банкомата с суммой меньше мнимального порога недопустимо") }
        guard amountOfMoney <= maximumMoneyCapacity else { fatalError("Ошибка. Создание банкомата с суммой больше максимального порога недопустимо") }
        
        self.idCashMachine = idCashMachine
        self.paymentSystem = paymentSystem
        self.maximumMoneyCapacity = maximumMoneyCapacity
        self.minimumMoneyCapacity = minimumMoneyCapacity
        self.secretKey = secretKey
        self.amountOfMoney = amountOfMoney
    }
}






// MARK: - Класс банкомата (методы/действия).

extension ATM {
    
    // [Кассиры] Включение/выключение банкомата.
    func changeStateCashMachine(to: AtmStatus, secretKey: String) {
        guard secretKey == self.secretKey else { fatalError("Ошибка операции. Введён не верный секретный ключ.\n") }
        if to != atmStatus {
            atmStatus = to
            print("Внимание! Банкомат \(atmStatus == .turnOn ? "включён." : "выключен.")\n")
        } else {
            print("Вы выбрали состояние, в котором уже находиться банкомат.\n")
        }
    }
    
    
    // [Кассиры] Метод пополнения или снятия денег из банкомата. #4-обработанных-ошибки
    func changeOfFundsInATM (secretKey: String, action: OperationATM, deposite: Int) -> (money: Int?, error: CashMachineError?){
        guard atmStatus == .turnOn else { return (nil, .cashMachineIsOff) }
        guard secretKey == self.secretKey else { return (nil, .invalidSecretKey) }
        guard deposite > 0 else { return (nil, .zeroDeposite) }
        
        switch action {
        case .addMoney:
            guard (deposite + amountOfMoney) <= maximumMoneyCapacity else { return (nil, .maximumCapacityExceeded(exceedsBy: maximumMoneyCapacity - amountOfMoney)) }
            amountOfMoney += deposite
            print("Вы пополнили банкомат на \(deposite) руб. Сейчас в банкомате: \(amountOfMoney) руб.\n");
            return (nil, nil)
        case .withdrawMoney:
            guard (amountOfMoney - deposite) >= minimumMoneyCapacity else { return (nil, .minimumCapacityExceeded(exceedsBy: amountOfMoney - minimumMoneyCapacity)) }
            amountOfMoney -= deposite
            print("Выдача наличных: \(deposite) руб. В банкомате осталось: \(amountOfMoney) руб.\n");
            return (deposite, nil)
        }
    }
    
    
    // [Пользователи] Метод пополнения или снятия денег с карты. #7-ошибок
    func exchangeOfFundsForUsersCard (card: inout BankCard, pinCode: UInt, action: OperationATM, deposite: Int) throws -> Int? {
        guard paymentSystem.contains(card.paymentSystem) else { throw CashMachineError.invalidPaymentSystem }
        guard card.pinCode == pinCode else { throw CashMachineError.invalidPinCode }
        guard card.cardStatus == .active else { throw CashMachineError.cardInBlock }
        guard deposite > 0 else { throw CashMachineError.zeroDeposite }
        
        switch action {
        case .addMoney:
            // exceedsBy в данный момент некорректный (необходимо поправить)
            guard (deposite + amountOfMoney) > maximumMoneyCapacity else { throw CashMachineError.maximumCapacityExceeded(exceedsBy: maximumMoneyCapacity) }
            card.setAmountOfMoney(card.amountOfMoney + Int(deposite))
            return nil
        case .withdrawMoney:
            guard card.amountOfMoney >= deposite else { throw CashMachineError.excessOfBalance }
            // exceedsBy в данный момент некорректный (необходимо поправить)
            guard (amountOfMoney - deposite) >= 0 else { throw CashMachineError.minimumCapacityExceeded(exceedsBy: minimumMoneyCapacity) }
            card.setAmountOfMoney(card.amountOfMoney - Int(deposite))
            return deposite
        }
    }
}






// MARK: -Результаты.

let ATM_001 = ATM(idCashMachine: "KRU&UR%", paymentSystem: [.mastercard, .visa], maximumMoneyCapacity: 5_000_000, minimumMoneyCapacity: 30_000, secretKey: "RHYF*R#IF*KNFAKJ", amountOfMoney: 50_000)

ATM_001.changeStateCashMachine(to: .turnOn, secretKey: "RHYF*R#IF*KNFAKJ")

// MARK: [Кассиры] Попробуем выполнить операцию, с неверным секкретным ключом.
let operation1 = ATM_001.changeOfFundsInATM(secretKey: "No", action: .addMoney, deposite: 20_000)
if let _ = operation1.money {
    print("\n🦺 [Кассиры] Попробуем выполнить операцию, с неверным секкретным ключом.")
    print("Операция прошла успешно, выдача наличных: \(operation1.money ?? 0) руб.")
} else if let error = operation1.error {
    print("\n🦺 [Кассиры] Попробуем выполнить операцию, с неверным секкретным ключом.")
    print(error.localozedDescription)
}

// MARK: [Кассиры] Попробуем выполнить операцию, выбрав нулевой депозит.
let operation2 = ATM_001.changeOfFundsInATM(secretKey: "RHYF*R#IF*KNFAKJ", action: .withdrawMoney, deposite: 0)
if let error = operation2.error {
    print("\n🦺 [Кассиры] Попробуем выполнить операцию, выбрав нулевой депозит.")
    print(error.localozedDescription)
}

// MARK: [Кассиры] Попробуем забрать из банкомата сумму, превышающую его наполненность.
let operation3 = ATM_001.changeOfFundsInATM(secretKey: "RHYF*R#IF*KNFAKJ", action: .withdrawMoney, deposite: 300_000)
if let error = operation3.error {
    print("\n🦺 [Кассиры] Попробуем забрать из банкомата сумму, превышающую его наполненность.")
    print(error.localozedDescription)
}

















































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
