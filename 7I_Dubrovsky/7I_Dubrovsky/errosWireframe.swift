//
//  errosWireframe.swift
//  7I_Dubrovsky
//
//  Created by Илья on 03.08.2021.
//

import Foundation

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
