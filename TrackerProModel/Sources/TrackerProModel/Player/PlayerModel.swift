//
//  PlayerModel.swift
//  
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import UIKit

public struct PlayerModel {
    public let id: Int?
    public let image: UIImage
    public let name: String
    public let howLong: String
    public let goals: String
    public let assistance: String
    public let penalties: String
    public let playerNumber: String

    public init(id: Int? = nil, image: UIImage, name: String, howLong: String, goals: String, assistance: String, penalties: String, playerNumber: String) {
        self.id = id
        self.image = image
        self.name = name
        self.howLong = howLong
        self.goals = goals
        self.assistance = assistance
        self.penalties = penalties
        self.playerNumber = playerNumber
    }
}

