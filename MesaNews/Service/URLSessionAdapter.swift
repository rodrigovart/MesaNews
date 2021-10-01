//
//  URLSessionAdapter.swift
//  URLSessionAdapter
//
//  Created by MAC on 28/09/21.
//

import Foundation

public final class URLSessionAdapter: HttpGet {
    func get(url: URL, completion: @escaping (Result<Data?, ApiError>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(Token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { news, response, error in
            
            if error == nil {
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 || response.statusCode == 201 else {
                    //Error Response
                    completion(.failure(.ErrorServer))
                    return
                }
                
                //Success News Received
                completion(.success(news))
                
            }else {
                completion(.failure(.NoConnectivity))
            }
        }.resume()
    }
}

