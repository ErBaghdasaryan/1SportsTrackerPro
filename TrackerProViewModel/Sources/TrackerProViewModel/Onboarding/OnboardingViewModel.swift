//
//  OnboardingViewModel.swift
//
//
//  Created by Er Baghdasaryan on 25.10.24.
//

import Foundation
import TrackerProModel

public protocol IOnboardingViewModel {
    var onboardingItems: [OnboardingPresentation] { get set }
    func loadData()
}

public class OnboardingViewModel: IOnboardingViewModel {

    private let onboardingService: IOnboardingService

    public var onboardingItems: [OnboardingPresentation] = []

    public init(onboardingService: IOnboardingService) {
        self.onboardingService = onboardingService
    }

    public func loadData() {
        onboardingItems = onboardingService.getOnboardingItems()
    }
}
