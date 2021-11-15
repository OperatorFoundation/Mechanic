//
//  Fix.swift
//
//
//  Created by Dr. Brandon Wiley on 11/15/21.
//

import Foundation

protocol Fix
{
    var name: String {get}
    func fix(_ package: Package) -> FixResult
}

public struct FixResult
{
    let package: Package
    let fixName: String
    let success: Bool
    let notes: String
}
