//
//  ChannelsViewModel.swift
//  TVChannelsSwiftUICombine
//
//  Created by Дмитрий Фёдоров on 17.01.2022.
//

import Foundation
import Combine

final class ChannelsViewModel: ObservableObject {
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
    @Published var channels: [Channel] = []
    @Published var programItems: [[ProgramItem]] = []
//    var programItems: [ProgramItem] = []

    var cancellation: AnyCancellable?
    let service = APIService()

    init() {
        fetchData()
    }

    //MARK: - Public Methods
    func convertTime(isoTime: String) -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        if let date = dateFormatter.date(from: isoTime) {
            let stringDate = "\(date)"
            return stringDate.components(separatedBy: " ")
        } else {
            return [""]
        }
    }

    //MARK: - Private Methods
    private func fetchData() {
        fetchChannels()
        //        fetchProgramItems()
    }

    private func fetchChannels() {
        cancellation = service.fetchChannels()
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { channels in
                self.channels = channels
                self.fetchProgramItems()
            })
    }

    private func fetchProgramItems() {
        cancellation = service.fetchProgramItems()
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { programItems in
//                self.programItems = programItems
                self.setTVProgram(items: programItems)
            })
    }

    private func setTVProgram(items: [ProgramItem]) {
        var progItems: [[ProgramItem]] = []

        let channelIDs = channels.map(\.id)
        for id in channelIDs {
            var programs = items
                .filter { id == $0.recentAirTime.channelID }
                .filter { convertTime(isoTime: $0.startTime).first == Constants.currentDate }

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
        let convertedTime = convertTime(isoTime: startTime)
        let hours = separateTime(time: convertedTime[1])[0] - 1
        let minutes = separateTime(time: convertedTime[1])[1]

        let time = hours * 60 + minutes
        return time
    }

    private func separateTime(time: String) -> [Int] {
        let separatedTime = time.components(separatedBy: ":").compactMap(Int.init)
        return separatedTime
    }
}



