//
//  Data.swift
//  Data
//
//  Created by siuzanna on 8/9/21.
//

import Foundation

// MARK: - Data
struct Welcome: Codable{
    let company: Company
}

// MARK: - Company
struct Company: Codable {
    let name: String
    let employees: [Employee]
}

// MARK: - Employee
struct Employee: Codable, Hashable {
    let name, phone_number: String
    let skills: [String]
}

