import Foundation

// MARK: Даётся любое число, необходимо вывести true если в данном числе имеются повторяющиеся числа, или false если повторений нет.

func searchNumbers(number: Int) -> Bool {
    let numbersInString = String(number)
    let array: [Int] = numbersInString.compactMap{Int(String($0))}
    var newArray: [Int] = []
    
    for i in array {
        if !newArray.isEmpty {
            for j in newArray {
                if i == j {
                    print("YES! I = \(i), J = \(j)")
                    return true
                }
            }
            newArray.append(i)
        } else {
            newArray.append(array[0])
        }
    }
    print("NO")
    return false
}

var b = searchNumbers(number: 123456117890)



// MARK: - Ввести любое число, и определить, верно ли, что в нем только одна цифра 9.

func searchNumberNine(number: Int) -> Bool {
    let numbersInString = String(number)
    let array: [Int] = numbersInString.compactMap{Int(String($0))}
    var newArray: [Int] = []
    
    for i in array {
        if i == 9 {
            newArray.append(i)
        }
    }
    
    if newArray.isEmpty || newArray.count > 1 {
        print("NO! В числе \(number) - \(newArray.count) девяток.")
        return false
    } else {
        print("YES! В числе \(number) - \(newArray.count) девятки(а).")
        return true
    }
}


var cc = searchNumberNine(number: 912999991249)



// MARK: - Ввести любое число, и определить, все ли числа в нём четные.

func oddInNumbers(number: Int) -> Bool {
    
    let numbersInString = String(number)
    let array: [Int] = numbersInString.compactMap{Int(String($0))}
    var newArray: [Int] = []
    
    for i in array {
        if i % 2 == 0 {
            newArray.append(i)
        }
    }
    
    if array == newArray {
        print("YES! В числе \(number) все цифры четные.")
        return true
    } else {
        print("NO! В числе \(number) не все цифры четные.")
        return false
    }
}

var nn = oddInNumbers(number: 24404668)



// MARK: - Ввести число, и вернуть true если числа расположены в порядке возрастания, или false если нет.
