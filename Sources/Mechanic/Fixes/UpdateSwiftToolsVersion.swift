//
//  UpdateSwiftToolsVersion.swift
//
//
//  Created by Dr. Brandon Wiley on 11/15/21.
//

import Foundation

public class UpdateSwiftToolsVersion: Fix
{
    static let desiredVersion = SwiftToolsVersion.desiredVersion
    var name: String = "Update Missing Swift Tools Version to \(SwiftToolsVersion.desiredVersion)?"

    func fix(_ package: Package) -> FixResult
    {
        guard let source = package.loadSource() else
        {
            return FixResult(package: package, fixName: self.name, success: false, notes: "Could not load Package.swift")
        }

        var maybeFixResult: FixResult? = nil
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
                    maybeFixResult = FixResult(package: package, fixName: self.name, success: true, notes: "")
                }
                else
                {
                    maybeFixResult = FixResult(package: package, fixName: self.name, success: false, notes: "Swift Tools Version is \(versionString), not \(SwiftToolsVersion.desiredVersion)")
                }
            }
        }

        guard let fixResult = maybeFixResult else
        {
            return FixResult(package: package, fixName: self.name, success: false, notes: "No Swift Tools Version found")
        }

        return fixResult
    }
}
