//
//  Bundle+Extension.swift
//  wanted_pre_onboarding
//
//  Created by rae on 2022/06/12.
//

import Foundation

extension Bundle {
    var weatherApiKey: String {
        guard let file = self.path(forResource: "Key", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["OPENWEATHER_API_KEY"] as? String else {
            fatalError("Key.plist에 OPENWEATHER_API_KEY 설정 필요")
        }
        return key
    }
}
