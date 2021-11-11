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
    
    fileprivate var urlRequest:URLRequest {
        var urlRequest = URLRequest(url:url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body

        headers?.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.field) }
        
        return urlRequest
    }
}

enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailure
    case statusNotOK
    case noDataInResponse
}

struct APIClient<ResponseType> where ResponseType:Decodable {
    typealias APIClientCompletion<Body> = (Result<Body,APIError>) -> Void

    private let session = URLSession.shared
        
    func fetch(_ request: APIRequest,_ completion: @escaping APIClientCompletion<ResponseType>)   {
        
        let task = session.dataTask(with: request.urlRequest) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed));
                return
            }
            if httpResponse.statusCode != 200 {
                completion(.failure(.statusNotOK));
                return
            }
            guard let data = data else {
                completion(.failure(.noDataInResponse));
                return
            }

            guard let response:ResponseType = data.decode() else {
                completion(.failure(.decodingFailure))
                return
            }
            
            completion(.success(response))
        }
        task.resume()
    }
    
    
}
