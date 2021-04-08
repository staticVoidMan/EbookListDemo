//
//  APIResource.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 09/04/21.
//

import Foundation

enum RequestError: Error {
    case urlInvalid
    case requestFailed(error: Error)
    case decodingFailed(error: Error)
    case noData
}

struct APIResource<Model: Decodable> {
    
    let url: String
    
    func request(completion: @escaping (Result<Model, RequestError>)->Void) {
        guard let url = URL(string: url) else {
            completion(.failure(RequestError.urlInvalid))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.requestFailed(error: error)))
                return
            }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Model.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingFailed(error: error)))
                }
            } else {
                completion(.failure(.noData))
            }
        }
        .resume()
    }
    
}
