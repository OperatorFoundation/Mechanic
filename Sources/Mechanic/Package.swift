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

    public func load() -> TopLevelDeclaration?
    {
        let url = URL(fileURLWithPath: self.path)
        let packageDotSwift = url.appendingPathComponent("Package.swift").path
        guard File.exists(packageDotSwift) else {return nil}

        guard let data = File.get(packageDotSwift) else {return nil}
        return getAST(data: data)
    }

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
