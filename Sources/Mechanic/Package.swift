//
//  Package.swift
//  
//
//  Created by Dr. Brandon Wiley on 11/14/21.
//

import Foundation
import Gardener
import AST
import Parser
import Source

public class Package
{
    let name: String
    let path: String

    public init(name: String, path: String)
    {
        self.name = name
        self.path = path
    }

    // Public functions
    public func loadData() -> Data?
    {
        let url = URL(fileURLWithPath: self.path)
        let packageDotSwift = url.appendingPathComponent("Package.swift").path
        guard File.exists(packageDotSwift) else {return nil}

        return File.get(packageDotSwift)
    }

    public func loadString() -> String?
    {
        guard let data = loadData() else {return nil}
        return data.string
    }

    public func loadSource() -> TopLevelDeclaration?
    {
        guard let data = loadData() else {return nil}
        return getAST(data: data)
    }

    public func saveData(data: Data) -> Bool
    {
        return File.put(self.path, contents: data)
    }

    public func saveString(string: String) -> Bool
    {
        let data = string.data
        return saveData(data: data)
    }

    public func saveSource(source: TopLevelDeclaration) -> Bool
    {
        let string = source.textDescription
        return saveString(string: string)
    }

    // Private functions
    func getAST(data: Data) -> TopLevelDeclaration?
    {
        guard let s = String(bytes: data, encoding: .utf8) else {
            return nil
        }

        let source = SourceFile(content: s)
        let parser = Parser(source: source)

        guard let topLevelDecl = try? parser.parse() else {
            return nil
        }

        return topLevelDecl
    }
}
