//
//  TimeView.swift
//  TVChannelsSwiftUICombine
//
//  Created by Дмитрий Фёдоров on 11.02.2022.
//

import SwiftUI

struct TimeView: View {
    var viewModel: ChannelsViewModel
    var index: Int

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(Color.green, lineWidth: Constants.borderWidth)
                .padding(Constants.cellPadding)
            Text(viewModel.timeCells[safeIndex: index] ?? "")
        }.frame(width: Constants.itemWidth,
                height: Constants.itemHeight)
    }
}
