//
//  OnboardingPresentationModel.swift
//
//
//  Created by Er Baghdasaryan on 25.10.24.
//

import Foundation

public struct OnboardingPresentation {
    public let image: String
    public let header: String
    public let description: String

    public init(image: String, header: String, description: String) {
        self.image = image
        self.header = header
        self.description = description
    }
}
