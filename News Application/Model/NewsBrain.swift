//
//  NewsBrain.swift
//  News Application
//
//  Created by Onur Alan on 15.05.2024.
//

import Foundation
import UIKit

class NewsBrain{
    static let sharedInstance = NewsBrain()
    
    func stringUrlToImage(stringUrl: String?, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrlString = stringUrl, let imageUrl = URL(string: imageUrlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            guard let imageData = data, let image = UIImage(data: imageData) else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
