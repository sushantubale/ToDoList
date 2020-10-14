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
    
    func multipleRequests<T, S>(_ request: URLRequest,_ decodingType1: T.Type,_ decodingType2: S.Type,_ queue: DispatchQueue = .main,_ retries: Int) -> AnyPublisher<(T, S), Error> where T: Decodable , S: Decodable {
                
        guard
            let postsURL = URL(string: UrlType.posts.rawValue),
            let commentsURL = URL(string: UrlType.comments.rawValue)
            else { fatalError("Invalid URL's")}
        
        let urlRequest1 = URLRequest(url: commentsURL)
        let urlRequest2 = URLRequest(url: postsURL)

        let postsPublisher =
            URLSession.shared.dataTaskPublisher(for: urlRequest1)
                .map { $0.data }
                .decode(type: T.self, decoder: JSONDecoder())
        let commentsPublisher =
            URLSession.shared.dataTaskPublisher(for: urlRequest2)
                .map { $0.data }
                .decode(type: S.self, decoder: JSONDecoder())
        return
            Publishers.Zip(postsPublisher, commentsPublisher)
                .eraseToAnyPublisher()
    }

}

private enum UrlType: String {
    case posts = "https://jsonplaceholder.typicode.com/posts"
    case comments = "https://jsonplaceholder.typicode.com/comments"
}

struct Post: Codable, Identifiable {
    let id: Int
    let title, body: String
}

struct Comment: Codable, Identifiable {
    let id, postId: Int
    let name, email, body: String
}
