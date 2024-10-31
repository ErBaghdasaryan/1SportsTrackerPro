//
//  MatchNavigatioModel.swift
//  
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import Foundation
import Combine

public final class MatchNavigatioModel {
    public var activateSuccessSubject: PassthroughSubject<Bool, Never>
    public var model: MatchModel
    
    public init(activateSuccessSubject: PassthroughSubject<Bool, Never>, model: MatchModel) {
        self.activateSuccessSubject = activateSuccessSubject
        self.model = model
    }
}

