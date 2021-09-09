
import Foundation

enum NetworkErrors: Error {
    case badRequest
    case unauthorized
}

enum StatusCode: Int {
    case ok = 200
    case created = 201
    case badRequest = 400
    case unauthorized = 401
}
