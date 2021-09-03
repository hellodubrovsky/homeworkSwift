//
//  cashMachineWireframe.swift
//  7I_Dubrovsky
//
//  Created by Илья on 03.08.2021.
//

import Foundation

// MARK: - Класс банкомата (каркас).

class ATM {
    internal let idCashMachine: String
    internal let paymentSystem: [PaymentSystems]
    internal let maximumMoneyCapacity: Int
    internal var minimumMoneyCapacity: Int
    internal var secretKey: String
    internal var amountOfMoney: Int
    internal var atmStatus: AtmStatus = .turnOff
    
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
