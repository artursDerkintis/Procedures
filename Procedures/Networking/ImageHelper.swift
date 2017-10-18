//
//  ImageHelper.swift
//  Procedures
//
//  Created by Arturs Derkintis on 18/10/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import UIKit

class ImageHelper {
    /// Loads image for this object
    ///
    /// - Parameter completion: returns image if there's no errors
    public static func loadImage(url: String?, completion: ((_ image: UIImage?) -> Void)?) {
        guard let imageURL = URL(string: url ?? "") else {
            completion?(nil)
            return
        }
        let urlSession = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if error != nil {
                completion?(nil)
            }
            guard let data = data else {
                completion?(nil)
                return
            }
            let image = UIImage(data: data)
            image?.accessibilityIdentifier = url
            completion?(image)
        }
        urlSession.resume()
    }
}
