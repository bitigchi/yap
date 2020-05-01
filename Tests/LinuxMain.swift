import XCTest

import yapTests

var tests = [XCTestCaseEntry]()
tests += yapTests.allTests()
XCTMain(tests)
