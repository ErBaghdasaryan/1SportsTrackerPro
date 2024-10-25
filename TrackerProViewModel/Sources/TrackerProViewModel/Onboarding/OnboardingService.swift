//
//  OnboardingService.swift
//  
//
//  Created by Er Baghdasaryan on 25.10.24.
//

import UIKit
import TrackerProModel

public protocol IOnboardingService {
    func getOnboardingItems() -> [OnboardingPresentation]
}

public class OnboardingService: IOnboardingService {
    public init() { }

    public func getOnboardingItems() -> [OnboardingPresentation] {
        [
            OnboardingPresentation(image: "onboarding-1",
                                        header: "Follow the progress",
                                        description: "Collect statistics on the team"),
            OnboardingPresentation(image: "onboarding-2",
                                        header: "Make a training plan",
                                        description: "Keep your team in good shape")
        ]
    }
}
