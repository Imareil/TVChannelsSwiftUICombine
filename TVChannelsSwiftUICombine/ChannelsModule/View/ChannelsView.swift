//
//  ChannelsView.swift
//  TVChannelsSwiftUICombine
//
//  Created by Дмитрий Фёдоров on 17.01.2022.
//

import Foundation

import SwiftUI

struct ChannelsView: View {
    @ObservedObject var viewModel = ChannelsViewModel()


    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: Constants.spacing) {
                    HStack(spacing: Constants.spacing) {
                        ForEach(0..<viewModel.timeCells.count, id: \.self) {index in
                            ZStack {
                                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                                    .stroke(Color.green, lineWidth: Constants.borderWidth)
                                    .padding(Constants.cellPadding)
                                Text("\(viewModel.timeCells[index])")
                            }.frame(width: Constants.itemWidth,
                                    height: Constants.itemHeight)
                        }
                        Spacer()
                    }
                    ForEach(0..<viewModel.programItems.count, id: \.self) { outIndex in
                        HStack(spacing: Constants.spacing) {
                            ZStack {
                                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                                    .stroke(Color.green, lineWidth: Constants.borderWidth)
                                    .padding(Constants.cellPadding)
                                HStack {
                                    VStack(alignment: .leading, spacing: Constants.vSpacing) {
                                        Text("\(outIndex + 1)")
                                        Text("\(viewModel.channels[outIndex].callSign)")
                                    }
                                    Spacer()
                                }.padding(Constants.padding)

                            }.frame(width: Constants.itemWidth)
                            ForEach(0..<viewModel.programItems[outIndex].count, id: \.self) { index in
                                ZStack {
                                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                                        .stroke(Color.green, lineWidth: Constants.borderWidth)
                                        .padding(Constants.cellPadding)
                                    HStack {
                                        Text("\(viewModel.programItems[outIndex][index].name)")
                                            .padding(Constants.padding)
                                        Spacer()
                                    }
                                }.frame(width: CGFloat(viewModel.programItems[outIndex][index].length * 4),
                                        height: Constants.itemHeight)
                            }
                            Spacer()
                        }
                    }
                }
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelsView()
    }
}

