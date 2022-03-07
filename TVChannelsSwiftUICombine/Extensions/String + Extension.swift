//
//  String + Extension.swift
//  TVChannelsSwiftUICombine
//
//  Created by Дмитрий Фёдоров on 11.02.2022.
//

import Foundation

extension String {
    enum DateType {
        case date
        case time
    }

    func convertTime(dateType: DateType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        guard let date = dateFormatter.date(from: self) else { return ""}

        let stringDate = "\(date)"
        switch dateType {
        case .date:
            return stringDate.components(separatedBy: " ")[0]
        case .time:
            return stringDate.components(separatedBy: " ")[1]
        }
    }
}
