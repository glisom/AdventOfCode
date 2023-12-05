import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day02Tests: XCTestCase {
    // Smoke test data provided in the challenge question
    let testData = """
    Game 1: 20 green, 3 red, 2 blue; 9 red, 16 blue, 18 green; 6 blue, 19 red, 10 green; 12 red, 19 green, 11 blue
    Game 5: 7 red, 7 green, 1 blue; 2 red, 1 green, 2 blue; 2 blue, 7 green; 7 red, 3 blue, 11 green
    """

    func testPart1() throws {
        let challenge = Day02(data: testData)
        XCTAssertEqual(challenge.part1() as! Int, 6)
    }

    func testPart2() throws {
        let challenge = Day02(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "37")
    }
}
