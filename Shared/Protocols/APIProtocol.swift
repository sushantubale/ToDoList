//
//  APIProtocol.swift
//  ToDoList
//
//  Created by Sushant-Old on 10/14/20.
//

import Foundation
import Combine

protocol APIProtocol {
    
    var session: URLSession { get }
    
    func execute<T>(_ request: URLRequest,_ decodingType: T.Type,_ queue: DispatchQueue,_ retries: Int) -> AnyPublisher<T, Error> where T: Decodable
}

extension APIProtocol {
    
    func execute<T>(_ request: URLRequest,_ decodingType: T.Type,_ queue: DispatchQueue = .main,_ retries: Int) -> AnyPublisher<T, Error> where T: Decodable {
        
        return session.dataTaskPublisher(for: request)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw APIError.responseFail
                }
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: queue)
            .retry(retries)
            .eraseToAnyPublisher()
    }
}
