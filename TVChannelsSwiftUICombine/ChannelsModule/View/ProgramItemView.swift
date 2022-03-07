//
//  File.swift
//  TVChannelsSwiftUICombine
//
//  Created by Дмитрий Фёдоров on 11.02.2022.
//

import SwiftUI

struct ProgramItemView: View {
    var viewModel: ChannelsViewModel

    var channelIndex: Int
    var index: Int

    var body: some View {
        NavigationLink {
            DetailsView(channelName: viewModel.channels[safeIndex: channelIndex]?.callSign ?? "",
                        itemName: viewModel.programItems[safeIndex: channelIndex]?[safeIndex: index]?.name ?? "",
                        startTime: viewModel.programItems[safeIndex: channelIndex]?[safeIndex: index]?.startTime ?? "",
                        length: viewModel.programItems[safeIndex: channelIndex]?[safeIndex: index]?.length ?? 0)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(Color.green, lineWidth: Constants.borderWidth)
                    .padding(Constants.cellPadding)
                HStack {

                    Text("\(viewModel.programItems[safeIndex: channelIndex]?[safeIndex: index]?.name ?? "")")
                        .multilineTextAlignment(.leading)
                        .padding(Constants.padding)
                        .foregroundColor(.green)
                    Spacer()
                }
            }.frame(width: CGFloat((viewModel.programItems[safeIndex: channelIndex]?[safeIndex: index]?.length ?? 0) * 4),
                    height: Constants.itemHeight)
        }.navigationTitle("TVProgram")
    }
}
