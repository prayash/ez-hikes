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

    @Published var isValid = false
    var data: Data?

    init(url: String) {
        guard let imageUrl = URL(string: url) else { return }

        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            guard let data = data, error == nil else { return }

            DispatchQueue.main.async {
                self.isValid = true
                self.data = data
            }
        }.resume()
    }

}
