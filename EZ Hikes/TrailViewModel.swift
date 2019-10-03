//
//  TrailViewModel.swift
//  EZ Hikes
//
//  Created by Prayash Thapa on 10/3/19.
//  Copyright © 2019 Viget. All rights reserved.
//

import SwiftUI
import Combine

final class TrailsViewModel: ObservableObject {

    @Published var trails: [Trail] = [Trail]()
    let uriStr = "https://www.hikingproject.com/data/get-trails?lat=40.0274&lon=-105.2519&maxDistance=10&key=200607244-6e26aa0c35f06e2b2879f1ff2dd569f1"

    func shuffle() {
        self.trails.shuffle()
    }

    func fetch() {
        guard let url = URL(string: uriStr) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                guard let data = data else { return }

                let payload = try JSONDecoder().decode(TrailsPayload.self, from: data)

                DispatchQueue.main.async {
                    self.trails = payload.trails
                }
            } catch {
                print("Failed To decode: ", error)
            }
        }.resume()
    }
}

