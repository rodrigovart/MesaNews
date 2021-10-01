//
//  HttpGet.swift
//  HttpGet
//
//  Created by MAC on 28/09/21.
//

import Foundation

protocol HttpGet {
    func get(url: URL, completion: @escaping (Result<Data?, ApiError>) -> Void)
}

// MARK: Enum information
enum ApiError: Error {
    
    case NoConnectivity
    case ErrorServer
    case ErrorJSON
}
