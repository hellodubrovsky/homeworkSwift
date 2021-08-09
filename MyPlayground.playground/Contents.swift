func apppendA(for count: UInt) -> String {
        var aString = "a"
        for _ in 0..<count {
            aString = aString + "a"
        }
       
        return aString
}

print(apppendA(for: 5))
print(apppendA(for: 6))
