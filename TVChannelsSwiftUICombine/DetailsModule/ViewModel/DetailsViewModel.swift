//
//  DetailsViewModel.swift
//  TVChannelsSwiftUICombine
//
//  Created by Дмитрий Фёдоров on 17.01.2022.
//

import Foundation
import Combine

final class DetailsViewModel: ObservableObject {

    @Published var channel: Channel?
    var cancellation: AnyCancellable?
    let service = APIService()

    func getDetails(id: Int) {
        cancellation = service.fetchChannel(id: id)
            .mapError({ (error) -> Error  in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { channel in
                self.channel = channel
            })
    }
}
