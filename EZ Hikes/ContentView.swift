//
//  ContentView.swift
//  EZ Hikes
//
//  Created by Prayash Thapa on 10/3/19.
//  Copyright © 2019 Viget. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {

    @ObservedObject var viewModel = TrailsViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.trails) { item in
                NavigationLink(destination: TrailDetail(title: item.name, text: item.summary, image: item.imgSmallMed)) {
                    HStack(spacing: 12.0) {
                        URLImage(url: item.imgSqSmall)

                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                                .lineLimit(2)
                                .lineSpacing(4)
                                .font(.subheadline)
                                .frame(height: 50.0)
                            Text(item.difficulty)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.vertical, 8.0)
            }
            .navigationBarTitle(Text("Trails"))
        }.onAppear {
            self.viewModel.fetch()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct URLImage: View {

    var url: String
    var width: CGFloat = 80.0
    var height: CGFloat = 80.0
    var placeholder = Image(systemName: "photo")

    @ObservedObject private var imageLoader = ImageLoader()

    var body: some View {
        if let image = imageLoader.image {
            return Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .background(Color.white)
                .cornerRadius(20)
                .onAppear { }
        } else {
            return placeholder
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .background(Color.white)
                .cornerRadius(20)
                .onAppear { self.imageLoader.load(url: self.url) }
        }
    }
}
