//
//  DataDecoder.swift
//  MoviesApp
//
//  Created by Juan Camilo Mendieta Hernández on 4/02/26.
//

import Foundation

protocol DataDecoderProtocol {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

class JSONDecoderWrapper: DataDecoderProtocol {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
}
