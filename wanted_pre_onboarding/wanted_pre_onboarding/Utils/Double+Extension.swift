//
//  Double+Extension.swift
//  wanted_pre_onboarding
//
//  Created by rae on 2022/06/10.
//

import Foundation

extension Double {
    func convertToCelsiusString() -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        
        let celsiusUnit = UnitTemperature.celsius
        let kelvin = self
        let convertResult = celsiusUnit.converter.value(fromBaseUnitValue: kelvin)
        let result = formatter.string(from: convertResult as NSNumber) ?? ""
        
        return result
    }
}
