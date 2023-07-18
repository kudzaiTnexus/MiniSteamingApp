func closestNumber(userNumber: Int, inNumbers numbers: [Int]) -> Int? {
    guard !numbers.isEmpty else { return nil }
    
    var closestNum = numbers[0]
    var minDiff = abs(userNumber - numbers[0])
    
    for num in numbers {
        let diff = abs(userNumber - num)
        if diff < minDiff {
            minDiff = diff
            closestNum = num
        }
    }
    
    return closestNum
}

let numbers = [50, 80, 200, 700]
let userNumber = 48
if let closest = closestNumber(userNumber: userNumber, inNumbers: numbers) {
    print("The closest number to \(userNumber) is \(closest)")
}
