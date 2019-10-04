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
    var width: CGFloat = 80.0
    var height: CGFloat = 80.0
    var aspectRatio: ContentMode = .fit
    var placeholder = Image(systemName: "photo")

    @ObservedObject private var imageLoader = ImageLoader()

    var body: some View {
        if let image = imageLoader.image {
            return Image(uiImage: image)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: aspectRatio)
                .frame(width: width, height: height)
                .background(Color.white)
                .cornerRadius(20)
                .onAppear { }
        } else {
            return placeholder
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: aspectRatio)
                .frame(width: width, height: height)
                .background(Color.white)
                .cornerRadius(20)
                .onAppear { self.imageLoader.load(url: self.url) }
        }
    }
}
