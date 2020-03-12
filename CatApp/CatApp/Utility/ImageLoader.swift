//
//  ImageLoader.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/20/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class ImageLoader: UIImageView {
    
    public func obtenerImagenDeUrl(url: String) {
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
        } else {
            let imagenDefecto = UIImage(named: "cat")
            self.image = imagenDefecto
            if let urlRequest =  URL(string: url) {
                URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                    if let datos = data {
                        let imagen = UIImage(data: datos)
                        if let image = imagen {
                            imageCache.setObject(image, forKey: url as NSString)
                            DispatchQueue.main.async {
                                self.image = image
                            }
                        }
                        
                    } else {
                        self.image = imagenDefecto
                    }
                    }.resume()
            }
        }
        
    }
}
