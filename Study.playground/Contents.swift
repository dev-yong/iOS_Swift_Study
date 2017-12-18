let numbers: [Int] = [Int]()
var even = numbers.filter { (number: Int) -> Bool in
    return number % 2 == 0
}

even = numbers.filter({ return $0 % 2 == 0 })
