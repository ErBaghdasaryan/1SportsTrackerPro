//
//  PlayerNavigationModel.swift
//  
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import Foundation
import Combine

public final class PlayerNavigationModel {
    public var activateSuccessSubject: PassthroughSubject<Bool, Never>
    public var model: PlayerModel
    
    public init(activateSuccessSubject: PassthroughSubject<Bool, Never>, model: PlayerModel) {
        self.activateSuccessSubject = activateSuccessSubject
        self.model = model
    }
}
