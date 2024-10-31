//
//  MatchModel.swift
//
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import UIKit

public struct MatchModel {
    public let id: Int?
    public let firstName: String
    public let firstImage: UIImage
    public let firstScore: String
    public let secondName: String
    public let secondImage: UIImage
    public let secondScore: String
    public let date: String
    public let city: String
    public let duration: String
    public let penalties: String
    public let playerName: String
    public let playerNumber: String
    public let isVictory: Bool

    public init(id: Int? = nil, firstName: String, firstImage: UIImage, firstScore: String, secondName: String, secondImage: UIImage, secondScore: String, date: String, city: String, duration: String, penalties: String, playerName: String, playerNumber: String, isVictory: Bool) {
        self.id = id
        self.firstName = firstName
        self.firstImage = firstImage
        self.firstScore = firstScore
        self.secondName = secondName
        self.secondImage = secondImage
        self.secondScore = secondScore
        self.date = date
        self.city = city
        self.duration = duration
        self.penalties = penalties
        self.playerName = playerName
        self.playerNumber = playerNumber
        self.isVictory = isVictory
    }

    public var totalScore: Int {
        let firstScoreInt = Int(firstScore) ?? 0
        let secondScoreInt = Int(secondScore) ?? 0
        return firstScoreInt + secondScoreInt
    }
}
