//
//  EventModel.swift
//  
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import UIKit

public struct EventModel {
    public let id: Int?
    public let image: UIImage
    public let startTime: String
    public let date: String

    public init(id: Int? = nil, image: UIImage, startTime: String, date: String) {
        self.id = id
        self.image = image
        self.startTime = startTime
        self.date = date
    }
}
