import Algorithms
import Foundation

struct Day01: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Splits input data into its component parts and convert from string.
    var entities: [String] {
        data.split(separator: "\n").map {
            String($0)
        }
    }

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        var sum = 0
        for entity in entities {
            let numbersOnly = entity.filter { $0.isNumber }
            let firstNum = numbersOnly.first
            let lastNum = numbersOnly.last
            if let number = Int("\(firstNum!)\(lastNum!)") {
                sum += number
            }
        }
        return sum
    }

    func part2() -> Any {
        var sum = 0
        let numbersText = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
        for entity in entities {
            var textAndNumbers = entity
            var indices: [(String, Int)] = []
            for num in numbersText {
                let firstIndex = textAndNumbers.firstRange(of: num)?.lowerBound
                if let firstIndex = firstIndex {
                    let intIndex = textAndNumbers.distance(from: textAndNumbers.startIndex, to: firstIndex)
                    indices.append((num, intIndex))
                }
            }
            indices.sort { a, b in
                b.1 > a.1
            }
            print(indices)
            for index in indices {
                let intVal = numbersText.distance(from: 0, to: numbersText.firstIndex(of: index.0)!) + 1
                let index = textAndNumbers.index(textAndNumbers.startIndex, offsetBy: index.1)
                textAndNumbers.replaceSubrange(index ... index, with: "\(intVal)")
            }
            print(textAndNumbers)
            let numbersOnly = textAndNumbers.filter { $0.isNumber }
            print(numbersOnly)
            let firstNum = numbersOnly.first
            let lastNum = numbersOnly.last
            if let number = Int("\(firstNum!)\(lastNum!)") {
                print(number)
                sum += number
            }
        }
        return sum
    }
}
