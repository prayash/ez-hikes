//
//  ContentView.swift
//  EZ Hikes
//
//  Created by Prayash Thapa on 10/3/19.
//  Copyright © 2019 Viget. All rights reserved.
//

import SwiftUI
import Combine

let statusBarHeight = UIApplication.shared.statusBarFrame.height

struct ContentView: View {

    @State var showProfile = false
    @ObservedObject var viewModel = TrailsViewModel()

    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ForEach(viewModel.featured) { trail in
                                NavigationLink(destination: TrailDetail(title: trail.name, text: trail.summary, image: trail.imgSmallMed)) {
                                    GeometryReader { geometry in
                                        CardView(
                                            title: trail.name,
                                            length: trail.lengthInMiles,
                                            image: "photo",
                                            color: Color(trail.difficulty),
                                            url: trail.imgMedium
                                        ).rotation3DEffect(Angle(degrees:
                                            Double(geometry.frame(in: .global).minX - 30) / -40
                                            ), axis: (x: 0, y: 10.0, z: 0))
                                    }.frame(width: 246, height: 360)
                                }
                            }
                        }
                        .frame(height: 320)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                        .padding(.top, 20)
                        Spacer()
                    }.listRowInsets(EdgeInsets())

                    Group {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Other Trails")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                Text(viewModel.numTrails)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .listRowInsets(EdgeInsets())
                        .padding(.leading, 20.0)
                        .padding(.vertical, 10.0)

                        ForEach(viewModel.trails) { trail in
                            NavigationLink(destination: TrailDetail(title: trail.name, text: trail.summary, image: trail.imgSmallMed)) {
                                HStack(spacing: 12.0) {
                                    URLImage(withURL: trail.imgSqSmall)

                                    VStack(alignment: .leading) {
                                        Text(trail.name)
                                            .font(.headline)

                                        Text(trail.lengthInMiles)
                                            .font(.subheadline)
                                            .foregroundColor(Color.gray)

                                        Text(trail.summary)
                                            .lineLimit(2)
                                            .font(.system(size: 15))
                                            .lineSpacing(4)
                                            .frame(height: 50)
                                    }
                                }.padding(.vertical, 8.0)
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("Featured Hikes"))
                .navigationBarItems(trailing:
                    Button(action: {
                        print("Toggling Profile.")
                        self.showProfile.toggle()
                    }) {
                        Image(systemName: "person.crop.circle")
                            .imageScale(.large)
                            .accessibility(label: Text("User Profile"))
                            .padding()
                    }
                )
            }.onAppear {
                print("Fetching trails.")
                self.viewModel.fetch()
            }.onDisappear {

            }

            ProfileView()
                .frame(minWidth: 0, maxWidth: 712)
                .cornerRadius(30)
                .shadow(radius: 20)
                .animation(.spring())
                .offset(y: showProfile ? statusBarHeight + 10 : UIScreen.main.bounds.height)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView : View {
    var title = "Royal Arch Loop"
    var length = "420 miles"
    var image = "photo"
    var color = Color("blue")
    var url = ""
    var shadowColor = Color("backgroundShadow")

    var body: some View {
        return ZStack {
            URLImage(withURL: url, width: 240, height: 320, aspectRatio: .fill)

            Group {
                Spacer()
            }.frame(width: 240, height: 320)
                .background(LinearGradient(gradient: Gradient(colors: [color, .clear]), startPoint: .top, endPoint: .bottom).opacity(1.0))

            VStack(alignment: .leading) {
                Text(length)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .padding(.leading, 30)

                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.trailing, 50)
                    .lineLimit(4)

                Spacer()
            }.frame(width: 240, height: 320)
        }
        .background(color)
        .cornerRadius(30)
        .frame(width: 240, height: 320)
        .shadow(color: shadowColor, radius: 20, x: 0, y: 20)
    }
}
