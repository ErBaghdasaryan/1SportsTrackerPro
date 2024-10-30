//
//  TeamModel.swift
//
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import UIKit

public struct TeamModel {
    public let id: Int?
    public let image: UIImage
    public let title: String

    public init(id: Int? = nil, image: UIImage, title: String) {
        self.id = id
        self.image = image
        self.title = title
    }
}
