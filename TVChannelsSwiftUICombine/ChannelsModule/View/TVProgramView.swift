//
//  ChannelsView.swift
//  TVChannelsSwiftUICombine
//
//  Created by Дмитрий Фёдоров on 17.01.2022.
//

import SwiftUI

struct TVProgramView: View {
    @ObservedObject var viewModel = ChannelsViewModel()

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack(spacing: Constants.spacing) {
                        HStack(spacing: Constants.spacing) {
                            ForEach(0..<viewModel.timeCells.count, id: \.self) {index in
                                TimeView(viewModel: viewModel, index: index)
                            }
                            Spacer()
                        }
                        ForEach(0..<viewModel.programItems.count, id: \.self) { channelIndex in
                            HStack(spacing: Constants.spacing) {
                                ChannelView(viewModel: viewModel, channelIndex: channelIndex)

                                ForEach(0..<(viewModel.programItems[safeIndex: channelIndex]?.count ?? 0),
                                        id: \.self) { index in
                                    ProgramItemView(viewModel: viewModel, channelIndex: channelIndex, index: index)
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }.padding()
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TVProgramView()
    }
}
#endif
