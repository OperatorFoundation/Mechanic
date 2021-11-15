import XCTest
@testable import Mechanic

import Gardener

final class MechanicTests: XCTestCase {
    func testFindPackages() throws
    {
        let mechanic = Mechanic()
        let home = File.homeDirectory()
        let startPath = home.path
        let packages = mechanic.findPackages(startingPath: startPath)
        print(packages.count)
        XCTAssert(packages.count > 0)
    }

    func testSwiftToolsVersion()
    {
        let mechanic = Mechanic()
        let home = File.homeDirectory()
        let startPath = home.path
        let packages = mechanic.findPackages(startingPath: startPath)
        XCTAssert(packages.count > 0)

        let package = packages[0]
        let rule = SwiftToolsVersion()
        let result = rule.check(package)
        print(result)
    }

    func testSwiftToolsVersionAllPackages()
    {
        let mechanic = Mechanic()
        let home = File.homeDirectory()
        let startPath = home.path
        let packages = mechanic.findPackages(startingPath: startPath)
        XCTAssert(packages.count > 0)

        let rule = SwiftToolsVersion()
        let results = packages.map
        {
            package in

            return rule.check(package)
        }

        for result in results
        {
            let passedString = result.passed ? "PASS" : "FAIL"
            if result.passed
            {
                print("\(result.package.name): \(passedString)")
            }
            else
            {
                print("\(result.package.name): \(passedString) - \(result.notes)")
            }
        }
    }
}
