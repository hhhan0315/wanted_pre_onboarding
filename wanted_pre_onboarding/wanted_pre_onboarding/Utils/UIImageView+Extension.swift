//
//  UIImageView+Extension.swift
//  wanted_pre_onboarding
//
//  Created by rae on 2022/06/13.
//

import UIKit

extension UIImageView {
    func setImageUrl(iconString: String) {
        let urlString = "https://openweathermap.org/img/wn/\(iconString)@2x.png"
        guard let url = URL(string: urlString) else { return }
        ImageLoader.shared.load(url) { [weak self] data in
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }
    }
}
