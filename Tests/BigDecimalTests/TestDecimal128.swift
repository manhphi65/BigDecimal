//
//  TestDecimal128.swift
//  BigDecimalTests
//
//  Created by Leif Ibsen on 03/09/2021.
//

//
// Test cases from General Decimal Arithmetic - speleotrove.com
//

import XCTest
@testable import BigDecimal
import BigInt

class TestDecimal128: XCTestCase {

    override func setUpWithError() throws {
        BigDecimal.NaNFlag = false
    }

    override func tearDownWithError() throws {
        XCTAssertFalse(BigDecimal.NaNFlag)
    }

    struct test {

        let input: String
        let result: String
        let mode: Rounding.Mode

        init(_ input: String, _ result: String, _ mode: Rounding.Mode = .halfEven) {
            self.input = input
            self.result = result
            self.mode = mode
        }
    }

    let tests1: [test] = [
        
        test("1.1111111111111111111111111111123450", "1.111111111111111111111111111112345", .ceiling),
        test("1.11111111111111111111111111111234549", "1.111111111111111111111111111112346", .ceiling),
        test("1.11111111111111111111111111111234550", "1.111111111111111111111111111112346", .ceiling),
        test("1.11111111111111111111111111111234551", "1.111111111111111111111111111112346", .ceiling),
        test("1.1111111111111111111111111111123450", "1.111111111111111111111111111112345", .up),
        test("1.11111111111111111111111111111234549", "1.111111111111111111111111111112346", .up),
        test("1.11111111111111111111111111111234550", "1.111111111111111111111111111112346", .up),
        test("1.11111111111111111111111111111234551", "1.111111111111111111111111111112346", .up),
        test("1.1111111111111111111111111111123450", "1.111111111111111111111111111112345", .floor),
        test("1.11111111111111111111111111111234549", "1.111111111111111111111111111112345", .floor),
        test("1.11111111111111111111111111111234550", "1.111111111111111111111111111112345", .floor),
        test("1.11111111111111111111111111111234551", "1.111111111111111111111111111112345", .floor),
        test("1.1111111111111111111111111111123450", "1.111111111111111111111111111112345", .halfDown),
        test("1.11111111111111111111111111111234549", "1.111111111111111111111111111112345", .halfDown),
        test("1.11111111111111111111111111111234550", "1.111111111111111111111111111112345", .halfDown),
        test("1.11111111111111111111111111111234650", "1.111111111111111111111111111112346", .halfDown),
        test("1.11111111111111111111111111111234551", "1.111111111111111111111111111112346", .halfDown),
        test("1.1111111111111111111111111111123450", "1.111111111111111111111111111112345", .halfEven),
        test("1.11111111111111111111111111111234549", "1.111111111111111111111111111112345", .halfEven),
        test("1.11111111111111111111111111111234550", "1.111111111111111111111111111112346", .halfEven),
        test("1.11111111111111111111111111111234650", "1.111111111111111111111111111112346", .halfEven),
        test("1.11111111111111111111111111111234551", "1.111111111111111111111111111112346", .halfEven),
        test("1.1111111111111111111111111111123450", "1.111111111111111111111111111112345", .down),
        test("1.11111111111111111111111111111234549", "1.111111111111111111111111111112345", .down),
        test("1.11111111111111111111111111111234550", "1.111111111111111111111111111112345", .down),
        test("1.11111111111111111111111111111234551", "1.111111111111111111111111111112345", .down),
        test("1.1111111111111111111111111111123450", "1.111111111111111111111111111112345", .halfUp),
        test("1.11111111111111111111111111111234549", "1.111111111111111111111111111112345", .halfUp),
        test("1.11111111111111111111111111111234550", "1.111111111111111111111111111112346", .halfUp),
        test("1.11111111111111111111111111111234650", "1.111111111111111111111111111112347", .halfUp),
        test("1.11111111111111111111111111111234551", "1.111111111111111111111111111112346", .halfUp),
        test("0.000000000", "0E-9"),
        test("0.00000000", "0E-8"),
        test("0.0000000", "0E-7"),
        test("0.000000", "0.000000"),
        test("0.00000", "0.00000"),
        test("0.0000", "0.0000"),
        test("0.000", "0.000"),
        test("0.00", "0.00"),
        test("0.0", "0.0"),
        test(".0", "0.0"),
        test("0.", "0"),
        test("100", "100"),
        test("1000", "1000"),
        test("999.9", "999.9"),
        test("1000.0", "1000.0"),
        test("1000.1", "1000.1"),
        test("10000", "10000"),
        test("1000000000000000000000000000000", "1000000000000000000000000000000"),
        test("10000000000000000000000000000000", "10000000000000000000000000000000"),
        test("100000000000000000000000000000000", "100000000000000000000000000000000"),
        test("1000000000000000000000000000000000", "1000000000000000000000000000000000"),
        test("10000000000000000000000000000000000", "1.000000000000000000000000000000000E+34"),
        test("10000000000000000000000000000000000", "1.000000000000000000000000000000000E+34"),
        test("10000000000000000000000000000000003", "1.000000000000000000000000000000000E+34"),
        test("10000000000000000000000000000000005", "1.000000000000000000000000000000000E+34"),
        test("100000000000000000000000000000000050", "1.000000000000000000000000000000000E+35"),
        test("10000000000000000000000000000000009", "1.000000000000000000000000000000001E+34"),
        test("100000000000000000000000000000000000", "1.000000000000000000000000000000000E+35"),
        test("100000000000000000000000000000000003", "1.000000000000000000000000000000000E+35"),
        test("100000000000000000000000000000000005", "1.000000000000000000000000000000000E+35"),
        test("100000000000000000000000000000000009", "1.000000000000000000000000000000000E+35"),
        test("1000000000000000000000000000000000000", "1.000000000000000000000000000000000E+36"),
        test("1000000000000000000000000000000000300", "1.000000000000000000000000000000000E+36"),
        test("1000000000000000000000000000000000500", "1.000000000000000000000000000000000E+36"),
        test("1000000000000000000000000000000000900", "1.000000000000000000000000000000001E+36"),
        test("10000000000000000000000000000000000000", "1.000000000000000000000000000000000E+37"),
        test("10000000000000000000000000000000003000", "1.000000000000000000000000000000000E+37"),
        test("10000000000000000000000000000000005000", "1.000000000000000000000000000000000E+37"),
        test("10000000000000000000000000000000009000", "1.000000000000000000000000000000001E+37"),
    ]

    func test1() throws {
        for t in tests1 {
            XCTAssertEqual(BigDecimal(t.input).round(Rounding(t.mode, 34)).asString(.scientific), t.result)
        }
    }
    
    func test2() throws {
        for _ in 0 ..< 100 {
            let x = BInt(1000000).randomLessThan()
            for i in -10 ... 10 {
                let b1 = BigDecimal(x, i * 600)
                let b2 = BigDecimal(-x, i * 600)
                XCTAssertEqual(b1, BigDecimal(b1.asDecimal128()))
                XCTAssertEqual(b2, BigDecimal(b2.asDecimal128()))
            }
        }
    }

}