//
//  URLImage.swift
//  EZ Hikes
//
//  Created by Prayash Thapa on 10/3/19.
//  Copyright © 2019 Viget. All rights reserved.
//

import SwiftUI
import Combine

struct URLImage: View {
    var url: String
    var width: CGFloat
    var height: CGFloat
    var aspectRatio: ContentMode

    @ObservedObject private var imageLoader: ImageLoader

    func imageFromData(_ data: Data) -> UIImage {
        UIImage(data: data) ?? UIImage()
    }

    init(withURL url: String, width: CGFloat = 80.0, height: CGFloat = 80.0, aspectRatio: ContentMode = .fit) {
        self.url = url
        self.width = width
        self.height = height
        self.aspectRatio = aspectRatio
        self.imageLoader = ImageLoader(url: url)
    }

    var body: some View {
        return Image(uiImage: imageLoader.isValid
            ? imageFromData(imageLoader.data!)
            : UIImage()
        )
        .resizable()
        .renderingMode(.original)
        .aspectRatio(contentMode: aspectRatio)
        .frame(width: width, height: height)
        .background(Color.clear)
        .cornerRadius(20)
    }
}
