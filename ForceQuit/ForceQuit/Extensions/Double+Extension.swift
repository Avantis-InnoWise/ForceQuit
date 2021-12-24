//
//  Double+Extension.swift
//  ForceQuit
//
//  Created by mac on 25.12.21.
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
