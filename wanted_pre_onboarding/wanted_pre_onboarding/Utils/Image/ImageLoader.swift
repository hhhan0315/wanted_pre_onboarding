//
//  ImageLoader.swift
//  wanted_pre_onboarding
//
//  Created by rae on 2022/06/12.
//

import Foundation

class ImageLoader {
    static let shared = ImageLoader()
    
    private let imageCacheManager = ImageCacheManager.shared
    
    func load(_ url: URL, completion: @escaping (Data) -> Void) {
        let key = url as NSURL
        if let cachedData = self.imageCacheManager.load(key) {
            completion(cachedData)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            self.imageCacheManager.save(key, data)
            completion(data)
        }.resume()
    }
}
