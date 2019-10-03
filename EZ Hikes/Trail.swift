//
//  Trail.swift
//  EZ Hikes
//
//  Created by Prayash Thapa on 10/3/19.
//  Copyright © 2019 Viget. All rights reserved.
//

// MARK: - Trail
public struct Trail: Codable, Identifiable {
    public let id: Int

    let name, type, summary, difficulty: String
    let stars: Double
    let starVotes: Int
    let location: String
    let url: String
    let imgSqSmall, imgSmall, imgSmallMed, imgMedium: String
    let length: Double
    let ascent, descent, high, low: Int
    let longitude, latitude: Double
    let conditionStatus, conditionDate: String
    let conditionDetails: String?
}

// MARK: - TrailsPayload
struct TrailsPayload: Codable {
    let trails: [Trail]
    let success: Int
}
