//
//  TrailDetail.swift
//  EZ Hikes
//
//  Created by Prayash Thapa on 10/3/19.
//  Copyright © 2019 Viget. All rights reserved.
//

import SwiftUI

struct TrailDetail: View {
    var title = "Trail Detail"
    var text = "Loading..."
    var image = "Photo"

    var body: some View {
        VStack(spacing: 20.0) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.heavy)
            URLImage(url: image, width: 400, height: 400)
            Text(text)
                .lineLimit(nil)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding(30.0)
    }
}

struct TrailDetail_Previews: PreviewProvider {
    static var previews: some View {
        TrailDetail()
    }
}
