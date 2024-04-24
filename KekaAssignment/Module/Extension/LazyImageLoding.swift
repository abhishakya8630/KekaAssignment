//
//  LazyImageView.swift
//  KekaAssignment
//
//  Created by Abhishek Kumar Shakya on 23/04/24.
//



import Foundation
import UIKit

final class LazyImageView: UIImageView {
    private var imageUrl: URL?
    private static let imageCache = NSCache<NSURL, UIImage>()
    
    func loadImage(fromURL imageURL: URL, placeHolderImage: String = "placeholder") {
        self.image = UIImage(named: placeHolderImage)
        self.imageUrl = imageURL
        
        if let cachedImage = LazyImageView.imageCache.object(forKey: imageURL as NSURL) {
            debugPrint("Image loaded from cache for URL: \(imageURL)")
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) else {
                debugPrint("Failed to download image from server for URL: \(imageURL)")
                return
            }
            
            DispatchQueue.main.async {
                LazyImageView.imageCache.setObject(image, forKey: imageURL as NSURL)
                if self?.imageUrl == imageURL {
                    self?.image = image
                }
            }
        }
    }
}




