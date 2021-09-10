

import Foundation

// MARK: - Data
struct JSON: Codable{
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

