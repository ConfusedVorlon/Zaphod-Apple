//
//  File.swift
//  
//
//  https://tim.engineering/break-up-third-party-networking-urlsession/
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}

struct HTTPHeader {
    let field: String
    let value: String
}

class APIRequest {
    let url:URL
    let method:HTTPMethod
    var headers: [HTTPHeader]?
    var body: Data?

    init(method: HTTPMethod, url: URL) {
        self.method = method
        self.url = url
    }

    init<Body: Encodable>(method: HTTPMethod,url: URL, body: Body) throws {
        self.method = method
        self.url = url
        self.body = try JSONEncoder().encode(body)
    }
}

struct APIResponse<Body> {
    let statusCode: Int
    let body: Body
}

extension APIResponse where Body == Data? {
    func decode<BodyType: Decodable>(to type: BodyType.Type) throws -> APIResponse<BodyType> {
        guard let data = body else {
            throw APIError.decodingFailure
        }
        let decodedJSON = try JSONDecoder().decode(BodyType.self, from: data)
        return APIResponse<BodyType>(statusCode: self.statusCode,
                                     body: decodedJSON)
    }
}

enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailure
    case statusNotOK
}

enum APIResult<Body> {
    case success(APIResponse<Body>)
    case failure(APIError)
}

struct APIClient {

    typealias APIClientCompletion = (APIResult<Data?>) -> Void

    private let session = URLSession.shared
    private static let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!

    func perform(_ request: APIRequest, _ completion: @escaping APIClientCompletion) {

        var urlRequest = URLRequest(url:request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body

        request.headers?.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.field) }

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed));
                return
            }
            if httpResponse.statusCode != 200 {
                completion(.failure(.statusNotOK));
                return
            }
            completion(.success(APIResponse<Data?>(statusCode: httpResponse.statusCode, body: data)))
        }
        task.resume()
    }
}
