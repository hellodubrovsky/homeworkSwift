import Foundation

// MARK: 1. Решить квадратное уравнение.
// Создал функцию 'quadratic' с помощью которой можно рещшить квадратное уравнение.

func quadratic(a: Int, b: Int, c: Int) -> [Int] {
    // Все найденные значения попробавл хранить в массиве.
    if a != 0 {
        let d = b * b - 4 * a * c
        // Выявляю кол-во корней. Если корни есть, высчитываю их и добавляю в массив.
        switch d {
        case ..<0:
            print("Дискриминант (\(d)) меньше 0. Уравнение не имеет корней. Возвращаю пустой массив.")
            return []
        case 1...:
            let x1 = (-b + Int(sqrt(Double(d)))) / (2 * a)
            let x2 = (-b - Int(sqrt(Double(d)))) / (2 * a)
            print("Дискриминант (\(d)) больше 0. В массив добавлено 2 корня.\nКорень X1 = \(x1).\nКорень Х2 = \(x2).")
            return [x1, x2]
        default:
            let x = -b / (2 * a)
            print("Дискриминант (\(d)) равен 0. В массив добавлен 1 корень.\nКорень X = \(x).")
            return [x]
        }
    } else {
        print("Значение 'а' не может быть равно 0. Возвращаю пустой массив.")
        return []
    }
}

//var result_1 = quadratic(a: 1, b: 12, c: 36)
//print(result_1)



// MARK: 2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.

func triangle(a: Double, b: Double) -> [Character: Double] {
    // Создал функцию, которая добавляет необходимые данные в словарь.
    // Элементы можно найти по соответстующим им названиям (S - площадь, P - периметр, H - гипотенуза).
    if a > 0 && b > 0 {
        let s: Double = 1 / 2 * a * b
        let h: Double = sqrt((a * a) + (b * b))
        let p: Double = a + b + h
        print("Площадь равна \(s).\nПериметр равен \(p).\nГипотенуза равна \(h).")
        return["S": s, "P": p, "H": h]
    } else {
        print("Значение катетов не может быть меньше 0. Возвращаю пустое множество.")
        return [:]
    }
}

//var result_2 = triangle(a: 5, b: 2)
//print(result_2)
//print(result_2["P"])



// MARK: 3. * Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.

func searchForContribution (contribution c: Double, percent p: Int, year y: Int = 5) -> Double? {
    if p > 0 && p < 100 && c > 0 {
        let o = ((c / 100 * Double(p)) * Double(y)) + c
        print("Сумма вклада через \(y) год/лет будет равна \(o).")
        return o
    } else {
        print("Не выполнено одно из условий (сумма вклада должна быть больше 0, процент должен быть больше 0 и меньше 100.)")
        return nil
    }
}

//var result_3 = searchForContribution(contribution: 1000, percent: 10)
//print(result_3)
