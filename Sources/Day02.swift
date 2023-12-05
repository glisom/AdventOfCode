import Algorithms
import Foundation

enum DiceColor: String {
    case Blue = "blue"
    case Red = "red"
    case Green = "green"
}

struct Handful {
    var color: DiceColor
    var amount: Int
}

struct Set {
    var handful: [Handful]
}

struct Game {
    var number: Int
    var sets: [Set]
}

func parseGameString(_ gameString: String) -> Game {
    // Extracting the game number and the rest of the string
    let components = gameString.components(separatedBy: ": ")
    guard components.count == 2, let gameNumber = Int(components[0].filter { "0" ... "9" ~= $0 }) else {
        fatalError("Invalid game format")
    }

    let setStrings = components[1].components(separatedBy: "; ")

    let sets = setStrings.map { setString -> Set in
        let handfulStrings = setString.components(separatedBy: ", ")
        let handfuls = handfulStrings.map { handfulString -> Handful in
            let components = handfulString.components(separatedBy: " ")
            guard components.count == 2, let amount = Int(components[0]), let color = DiceColor(rawValue: components[1]) else {
                fatalError("Invalid format for handful")
            }
            return Handful(color: color, amount: amount)
        }
        return Set(handful: handfuls)
    }

    return Game(number: gameNumber, sets: sets)
}

struct Day02: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Splits input data into its component parts and convert from string.
    var games: [Game] {
        data.split(separator: "\n").map {
            parseGameString(String($0))
        }
    }

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        // The Elf would first like to know which games would have been possible if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?
        var sum = 0
        let maxRed = 12
        let maxGreen = 13
        let maxBlue = 14
        for game in games {
            var skipGame = false
            for set in game.sets {
                for handful in set.handful {
                    if handful.color == .Blue && handful.amount > maxBlue {
                        skipGame = true
                    }
                    if handful.color == .Green && handful.amount > maxGreen {
                        skipGame = true
                    }
                    if handful.color == .Red && handful.amount > maxRed {
                        skipGame = true
                    }
                }
            }
            sum += skipGame ? 0 : game.number
        }
        return sum
    }

    func part2() -> Any {
        var sum = 0
        for game in games {
            var minBlue = 0
            var minGreen = 0
            var minRed = 0
            for set in game.sets {
                for handful in set.handful {
                    if handful.color == .Blue && handful.amount > minBlue {
                        minBlue = handful.amount
                    }
                    if handful.color == .Green && handful.amount > minGreen {
                        minGreen = handful.amount
                    }
                    if handful.color == .Red && handful.amount > minRed {
                        minRed = handful.amount
                    }
                }
            }
            sum += (minBlue * minRed * minGreen)
        }
        return sum
    }
}
