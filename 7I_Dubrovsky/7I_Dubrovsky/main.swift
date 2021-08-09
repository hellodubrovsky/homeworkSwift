//
//  main.swift
//  7I_Dubrovsky
//
//  Created by Илья on 03.08.2021.

import Foundation

// MARK: Результаты.



// MARK: - Создадим банкомат.
let ATM_001 = try? ATM(idCashMachine: "KRU&UR%", paymentSystem: [.mastercard, .visa], maximumMoneyCapacity: 5_000_000, minimumMoneyCapacity: 30_000, secretKey: "RHYF*R#IF*KNFAKJ", amountOfMoney: 50_000)

/*


// MARK: - Создадим несколько банковских карт.
var banKCard_1 = BankCard(nameOfCardHolder: "Андрей", paymentSystem: .maestro, amountOfMoney: 0)




// MARK: - [Кассиры] Попробуем включить банкомат, с неверным секкретным ключом.
print("\n🦺 [Кассиры] Попробуем выполнить операцию, с неверным секкретным ключом.")
do {
    try ATM_001.changeStateCashMachine(to: .turnOn, secretKey: "BLA-BL1")
    print("Операция включения банкомата прошла успешно.")
} catch {
    // Если ошибка есть в CashMachineError, то выводим её, иначе ошибку протокола Error.
    if let error = error as? CashMachineError {
        print("1: \(error.localozedDescription)")
    } else {
        print("2: \(error.localizedDescription)")
    }
}



// MARK: - [Кассиры] Попробуем включить банкомат, с верным секкретным ключом.
print("\n🦺 [Кассиры] Попробуем выполнить операцию, с верным секкретным ключом.")
do {
    try ATM_001.changeStateCashMachine(to: .turnOn, secretKey: "RHYF*R#IF*KNFAKJ")
    print("Операция включения банкомата прошла успешно.")
} catch {
    if let error = error as? CashMachineError {
        print("1: \(error.localozedDescription)")
    } else {
        print("2: \(error.localizedDescription)")
    }
}


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

*/
