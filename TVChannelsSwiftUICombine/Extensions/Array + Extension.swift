//
//  Array + Extension.swift
//  TVChannelsSwiftUICombine
//
//  Created by Дмитрий Фёдоров on 18.01.2022.
//

import Foundation

public extension Array {
    subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else { return nil }
        return self[index]
    }
}
