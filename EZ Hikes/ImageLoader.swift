//
//  ImageLoader.swift
//  EZ Hikes
//
//  Created by Prayash Thapa on 10/3/19.
//  Copyright © 2019 Viget. All rights reserved.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {

    @Published var image: UIImage?

    func load(url: String) {
        guard let imageUrl = URL(string: url) else {
            fatalError("imageURL is not defined.")
        }

        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.image = nil
                }

                return
            }

            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }

}

