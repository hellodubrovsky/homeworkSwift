//
//  mandatoryEnum.swift
//  7I_Dubrovsky
//
//  Created by Илья on 03.08.2021.
//

import Foundation

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
