//
//  ChannelView.swift
//  TVChannelsSwiftUICombine
//
//  Created by Дмитрий Фёдоров on 11.02.2022.
//

import SwiftUI

struct ChannelView: View {
    var viewModel: ChannelsViewModel
    var channelIndex: Int

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(Color.green, lineWidth: Constants.borderWidth)
                .padding(Constants.cellPadding)
            HStack {
                VStack(alignment: .leading, spacing: Constants.vSpacing) {
                    Text("\(channelIndex + 1)")
                    Text(viewModel.channels[safeIndex: channelIndex]?.callSign ?? "")
                }
                Spacer()
            }.padding(Constants.padding)

        }.frame(width: Constants.itemWidth)
    }
}
