//
//  ProfileView.swift
//  EZ Hikes
//
//  Created by Prayash Thapa on 11/8/19.
//  Copyright © 2019 Viget. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @State var show = false

    var body: some View {
        ZStack {
            BlurView(style: .systemMaterial)

            TitleView()
                .blur(radius: show ? 20 : 0)
                .animation(.default)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct TitleView : View {
    var body: some View {
        return VStack {
            HStack {
                Text("User Profile")
                    .font(.headline)
                    .fontWeight(.heavy)
                    Spacer()
                }
                Text("Hello. This is teh profile screen.")
                Spacer()
            }
            .padding()
    }
}
