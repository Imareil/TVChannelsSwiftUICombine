//
//  ChannelsViewModel.swift
//  TVChannelsSwiftUICombine
//
//  Created by Дмитрий Фёдоров on 17.01.2022.
//

import Foundation
import Combine
import SwiftUI

final class ChannelsViewModel: ObservableObject {
    @Published var channels: [Channel] = []
    @Published var programItems: [[ProgramItem]] = []
    @Published var timeCells: [String] = {
        let hours = Array(1...23)
        var timeText: [String] = []
        for index in hours {
            timeText.append("\(index):00")
            timeText.append("\(index):30")
        }
        let currentDateText = "Today,\n\(Constants.currentDate)"
        timeText.insert(currentDateText, at: 0)
        return timeText
    }()

    private var subscriptions = Set<AnyCancellable>()
    private let service: APIServiceProtocol

//    private let service: APIService

    init(service: APIServiceProtocol) {
        self.service = service
        fetchData()
    }

    init(apiSevice: APIServiceProtocol = APIService()) {
        self.service = apiSevice
        fetchData()
    }

    //MARK: - Private Methods
    private func fetchData() {
        fetchChannels()
        fetchProgramItems()
    }

    private func fetchChannels() {
        service.fetchChannels()
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink { _ in } receiveValue: { channels in
                self.channels = channels
            }.store(in: &subscriptions)
    }

    private func fetchProgramItems() {
        service.fetchProgramItems()
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { items in
                self.setTVProgram(items: items)
            })
            .store(in: &subscriptions)
    }

    private func setTVProgram(items: [ProgramItem]) {
        var progItems: [[ProgramItem]] = []

        let channelIDs = channels.map(\.id)
        for id in channelIDs {
            var programs = items
                .filter { id == $0.recentAirTime.channelID }
                .filter { $0.startTime.convertTime(dateType: .date) == Constants.currentDate }

            let checkedStartTime = checkstartTime(startTime: programs.first?.startTime ?? "")

            if checkedStartTime > 0 {
                let recent = RecentAirTime(id: 0, channelID: 0)
                let prItem = ProgramItem(startTime: Constants.startTime,
                                         recentAirTime: recent,
                                         length: checkedStartTime,
                                         name: Constants.noProgram)
                programs.insert(prItem, at: 0)
            }
            
            progItems.append(programs)
        }
        programItems = progItems
    }

    private func checkstartTime(startTime: String) -> Int {
        let convertedTime = startTime.convertTime(dateType: .time)
        let hours = separateTime(time: convertedTime)[0] - 1
        let minutes = separateTime(time: convertedTime)[1]

        let time = hours * 60 + minutes
        return time
    }

    private func separateTime(time: String) -> [Int] {
        let separatedTime = time.components(separatedBy: ":").compactMap(Int.init)
        return separatedTime
    }
}



