//
//  cashMachineActions .swift
//  7I_Dubrovsky
//
//  Created by Илья on 03.08.2021.
//

import Foundation

// MARK: - Класс банкомата (методы/действия).

extension ATM {
    
    // [Кассиры] Включение/выключение банкомата.
    func changeStateCashMachine(to: AtmStatus, secretKey: String) throws {
        guard secretKey == self.secretKey else { throw CashMachineError.invalidSecretKey}
        
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
    
    
    // [Пользователи] Метод пополнения или снятия денег с карты. #8-ошибок
    func exchangeOfFundsForUsersCard (card: inout BankCard, pinCode: UInt, action: OperationATM, deposite: Int) throws -> Int? {
        guard atmStatus == .turnOn else { throw CashMachineError.cashMachineIsOff }
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
