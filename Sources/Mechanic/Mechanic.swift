import Foundation
import Gardener

public class Mechanic
{
    let checks: [Check] = [
        SwiftToolsVersion()
    ]

    public init()
    {
    }

    // Public functions
    public func findPackages(startingPath: String) -> [Package]
    {
        guard File.exists(startingPath) else {return []}
        let baseURL = URL(fileURLWithPath: startingPath)
        guard let files = File.contentsOfDirectory(atPath: startingPath) else {return []}
        return files.compactMap
        {
            relativePath in

            let url = baseURL.appendingPathComponent(relativePath)

            if self.hasPackageDotSwift(url.path)
            {
                return Package(name: relativePath, path: url.path)
            }
            else
            {
                return nil
            }
        }
    }

    public func runChecks(package: Package)
    {
        for rule in self.checks
        {
            rule.check(package)
        }
    }

    // Private functions
    func hasPackageDotSwift(_ path: String) -> Bool
    {
        let url = URL(fileURLWithPath: path)
        let packageDotSwift = url.appendingPathComponent("Package.swift").path
        return File.exists(packageDotSwift)
    }
}
