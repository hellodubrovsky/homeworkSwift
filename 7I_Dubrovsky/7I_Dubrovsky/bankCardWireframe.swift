//
//  bankCardWireframe.swift
//  7I_Dubrovsky
//
//  Created by Илья on 03.08.2021.
//

import Foundation

// MARK: - Структура банковской карты.

struct BankCard {
    let nameOfCardHolder: String
    let paymentSystem: PaymentSystems
    let pinCode = UInt.random(in: 1000...9999)
    var cardStatus: CardsStatus = .active
    private(set) var amountOfMoney: Int
    
    // Актуализация баланса на карте.
    mutating func setAmountOfMoney(_ value: Int) {
        self.amountOfMoney = value
    }
    
    init(nameOfCardHolder: String, paymentSystem: PaymentSystems, amountOfMoney: Int) {
        self.nameOfCardHolder = nameOfCardHolder
        self.paymentSystem = paymentSystem
        self.amountOfMoney = amountOfMoney
        
        print("Карта создана. \(nameOfCardHolder) пин-код вашей карты: \(pinCode).")
    }
}
