//
//  File.swift
//  
//
//  Created by Luca on 15/02/2022.
//

import Foundation

extension Date {
    var dayInYear: Int {
        let cal = Calendar.current
        return cal.ordinality(of: .day, in: .year, for: self) ?? 0
    }
}
