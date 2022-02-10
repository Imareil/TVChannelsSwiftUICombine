//
//  APIService.swift
//  TVChannelsSwiftUICombine
//
//  Created by Дмитрий Фёдоров on 17.01.2022.
//

import Foundation
import Alamofire
import Combine

protocol APIServiceProtocol {
    func fetchChannels() -> AnyPublisher<[Channel], AFError>
    func fetchProgramItems() -> AnyPublisher<[ProgramItem], AFError>
    func fetchChannel(id: Int) -> AnyPublisher<Channel, AFError>
}

class APIService: APIServiceProtocol {
    func fetchChannels() -> AnyPublisher<[Channel], AFError> {
        let url = Hosts.channelsHost
        let publisher = AF.request(url).publishDecodable(type: [Channel].self)
        return publisher.value()
    }

    func fetchProgramItems() -> AnyPublisher<[ProgramItem], AFError> {
        let url = Hosts.programItemsHost
        let publisher = AF.request(url).publishDecodable(type: [ProgramItem].self)
        return publisher.value()
    }

    func fetchChannel(id: Int) -> AnyPublisher<Channel, AFError> {
        let url = Hosts.channelsHost
        let publisher = AF.request(url).publishDecodable(type: Channel.self)
        return publisher.value()
    }

}


