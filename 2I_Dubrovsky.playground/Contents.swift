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
//var newFilteredArray = removeEvenAndNonDivisibleThree(array: increasingArray)
//print(newFilteredArray)



// MARK: 5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.



























//Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.
// MARK: 6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
//
//a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
//b. Пусть переменная p изначально равна двум — первому простому числу.
//c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p..
//d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
//e. Повторять шаги c и d, пока возможно.
