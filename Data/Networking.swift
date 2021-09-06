//
//  Networking.swift
//  Avito_Intern
//
//  Created by siuzanna on 3/9/21.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable{
    let company: Company
}

// MARK: - Company
struct Company: Codable {
    let name: String
    let employees: [Employee]
}

// MARK: - Employee
struct Employee: Codable {
    let name, phone_number: String
    let skills: [String]
}


var newsPosts: Welcome?

func getMethod(complited: @escaping () -> ()) {
    guard let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else {
        print("Error: cannot create URL")
        return
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if error == nil {
            do {
                let decoder = JSONDecoder()
                newsPosts = try decoder.decode(Welcome.self, from: data!)
                DispatchQueue.main.async {
                    complited()
                }
            } catch {
                print("Error: Trying to convert JSON data to string: \(error)")
                return
            }
        }
    }.resume()
}
