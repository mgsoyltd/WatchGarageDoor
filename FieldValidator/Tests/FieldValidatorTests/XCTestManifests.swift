import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FieldValidatorTests.allTests),
    ]
}
#endif
