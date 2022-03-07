//
//  DetailsView.swift
//  TVChannelsSwiftUICombine
//
//  Created by Дмитрий Фёдоров on 17.01.2022.
//

import SwiftUI

struct DetailsView: View {
    var channelName: String
    var itemName: String
    var startTime: String
    var length: Int

    var body: some View {
        VStack(spacing: 50) {
            Text("Channel name: \(channelName)")
            Text("Program name: \(itemName)")
            Text("Start time: \(startTime.convertTime(dateType: .time))")
            Text("Length: \(length) min")
                .navigationTitle(itemName)
        }

    }

}
