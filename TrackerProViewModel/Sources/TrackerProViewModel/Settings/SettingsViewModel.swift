//
//  SettingsViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 29.10.24.
//

import Foundation
import TrackerProModel

public protocol ISettingsViewModel {
    
}

public class SettingsViewModel: ISettingsViewModel {

    private let settingsService: ISettingsService

    public init(settingsService: ISettingsService) {
        self.settingsService = settingsService
    }
}
