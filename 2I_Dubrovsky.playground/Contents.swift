import Foundation

// MARK: 1. Написать функцию, которая определяет, четное число или нет.
func evenOrOdd(number: Int) -> Bool {return number % 2 == 0}
//let exampleTask_1_1 = evenOrOdd(number: 0)
//let exampleTask_1_2 = evenOrOdd(number: 3)
//let exampleTask_1_3 = evenOrOdd(number: -6)



// MARK: 2. Написать функцию, которая определяет, делится ли число без остатка на 3.
func remainderOfDivision(number: Int) -> Bool {return number % 3 == 0}
//let exampleTask_2_1 = remainderOfDivision(number: 9)
//let exampleTask_2_2 = remainderOfDivision(number: -22)
//let exampleTask_2_3 = remainderOfDivision(number: 0)



// MARK: 3. Создать возрастающий массив из 100 чисел.
let increasingArray: [Int] = Array (1...100)
//print(increasingArray)



// MARK: 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
func removeEvenAndNonDivisibleThree(array: [Int]) -> [Int] {
    return array.filter({ !evenOrOdd(number: $0) && !remainderOfDivision(number: $0) })
}
//var exampleFilteredArray = removeEvenAndNonDivisibleThree(array: increasingArray)
//print(exampleFilteredArray)



// MARK: 5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.
// Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.

func addingFibonacciNumbers(amountOfNumbers num: Int) -> [Int] {
    switch num {
    case ..<1:
        print("Количество новых элементов, не может быть меньше или равно 0. Возвращаю пустой массив.")
        return []
    case 1:
        print("Возвращаю массив с \(num) элментом(и).")
        return [0]
    case 2:
        print("Возвращаю массив с \(num) элментом(и).")
        return [0, 1]
    default:
        print("Возвращаю массив с \(num) элментом(и).")
        var array = [0, 1]
        for i in 2...num-1 {
            array.append((array[i-1]) + (array[i-2]))
        }
        return array
    }
}

//let exampleTask_5_1 = addingFibonacciNumbers(amountOfNumbers: 50)
//print(exampleTask_5_1)
//let exampleTask_5_2 = addingFibonacciNumbers(amountOfNumbers: 3)
//print(exampleTask_5_2)
//let exampleTask_5_3 = addingFibonacciNumbers(amountOfNumbers: -50)
//print(exampleTask_5_3)



// MARK: 6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
/*
a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
b. Пусть переменная p изначально равна двум — первому простому числу.
c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p..
d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
e. Повторять шаги c и d, пока возможно. */
