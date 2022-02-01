//
//  ImageDownloader.swift
//  GeeksForGeeksChallenge
//
//  Created by Dhirendra Verma on 01/02/22.
//

import UIKit

// Global variable or stored in a singleton / top level object
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func downloadImage(from imgURL: String) -> URLSessionDataTask? {
        guard let url = URL(string: imgURL) else { return nil }

        // set initial image to nil so it doesn't use the image from a reused cell
        image = nil

        // check if the image is already in the cache
        if let imageToCache = imageCache.object(forKey: imgURL as NSString) {
            self.image = imageToCache
            return nil
        }

        // download the image asynchronously
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err)
                return
            }

            DispatchQueue.main.async {
                // create UIImage
                let imageToCache = UIImage(data: data!)
                // add image to cache
                imageCache.setObject(imageToCache!, forKey: imgURL as NSString)
                self.image = imageToCache
            }
        }
        task.resume()
        return task
    }
}
