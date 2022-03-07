//
//  APIService.swift
//  TVChannelsSwiftUICombine
//
//  Created by Дмитрий Фёдоров on 17.01.2022.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

protocol APIServiceProtocol {
    func fetchChannels() -> AnyPublisher<[Channel], Swift.Error>
    func fetchProgramItems() -> AnyPublisher<[ProgramItem], AFError>
}

final class APIService: APIServiceProtocol {
    enum Error: Swift.Error, CustomStringConvertible {
        case network
        case parsing
        case unknown

        var description: String {
            switch self {
            case .network:
                return "Request to API server failed"
            case .parsing:
                return "Failed parsing return from server"
            case .unknown:
                return "An unknown error occured"
            }
        }
    }

    func fetchChannels() -> AnyPublisher<[Channel], Swift.Error> {
        let url = URL(string: Hosts.channelsHost)!
        let request = URLRequest(url: url)

        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { data, _ -> Data in
                guard let obj = try? JSONSerialization.jsonObject(with: data),
                      let dict = obj as? [String : Any],
                      dict["status"] as? Int == 404
                else { return data }

                throw APIService.Error.unknown
            }
            .decode(type: [Channel].self, decoder: JSONDecoder())
            .mapError { error -> APIService.Error in
                switch error {
                case is URLError:
                    return .network
                case is DecodingError:
                    return .parsing
                default:
                    return error as? APIService.Error ?? .unknown
                }
            }
            .eraseToAnyPublisher()
    }

    func fetchProgramItems() -> AnyPublisher<[ProgramItem], AFError> {
        let url = Hosts.programItemsHost
        let publisher = AF.request(url).publishDecodable(type: [ProgramItem].self)
        return publisher.value()
    }
}


