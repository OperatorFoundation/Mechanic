//
//  Check.swift
//  
//
//  Created by Dr. Brandon Wiley on 11/15/21.
//

import Foundation

protocol Check
{
    var name: String {get}
    func check(_ package: Package) -> CheckResult
}

public struct CheckResult
{
    let package: Package
    let checkName: String
    let passed: Bool
    let notes: String
}
