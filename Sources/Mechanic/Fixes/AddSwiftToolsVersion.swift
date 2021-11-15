//
//  AddSwiftToolsVersion.swift
//
//
//  Created by Dr. Brandon Wiley on 11/15/21.
//

import Foundation

public class AddSwiftToolsVersion: Fix
{
    static let desiredVersion = SwiftToolsVersion.desiredVersion
    var name: String = "Add Missing Swift Tools Version of \(SwiftToolsVersion.desiredVersion)?"

    func fix(_ package: Package) -> FixResult
    {
        guard let packageString = package.loadString() else
        {
            return FixResult(package: package, fixName: self.name, success: false, notes: "Could not load Package.swift")
        }

        let swiftToolsVersion = """
            // swift-tools-version:\(AddSwiftToolsVersion.desiredVersion)\n
            """

        let fixed = swiftToolsVersion + packageString
        guard package.saveString(string: fixed) else
        {
            return FixResult(package: package, fixName: self.name, success: false, notes: "Could not save modified Package.swift")
        }

        return FixResult(package: package, fixName: self.name, success: true, notes: "")
    }
}
