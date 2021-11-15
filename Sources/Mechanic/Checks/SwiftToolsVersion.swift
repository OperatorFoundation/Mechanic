//
//  SwiftToolsVersion.swift
//  
//
//  Created by Dr. Brandon Wiley on 11/15/21.
//

import Foundation

public class SwiftToolsVersion: Check
{
    public static let desiredVersion = "5.5"
    var name: String = "Is Swift Tools Version \(SwiftToolsVersion.desiredVersion)?"

    func check(_ package: Package) -> CheckResult
    {
        guard let source = package.loadSource() else
        {
            return CheckResult(package: package, checkName: self.name, passed: false, notes: "Could not load Package.swift")
        }

        var maybeCheckResult: CheckResult? = nil
        for comment in source.comments
        {
            let content = comment.content
            let trimmed = content.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            if trimmed.starts(with: "swift-tools-version")
            {
                let parts = trimmed.split(separator: ":")
                guard parts.count == 2 else {continue}

                let versionString = parts[1]
                if versionString == SwiftToolsVersion.desiredVersion
                {
                    maybeCheckResult = CheckResult(package: package, checkName: self.name, passed: true, notes: "")
                }
                else
                {
                    maybeCheckResult = CheckResult(package: package, checkName: self.name, passed: false, notes: "Swift Tools Version is \(versionString), not \(SwiftToolsVersion.desiredVersion)")
                }
            }
        }

        guard let checkResult = maybeCheckResult else
        {
            return CheckResult(package: package, checkName: self.name, passed: false, notes: "No Swift Tools Version found")
        }

        return checkResult
    }
}
