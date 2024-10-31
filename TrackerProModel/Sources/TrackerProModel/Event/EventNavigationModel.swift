//
//  EventNavigationModel.swift
//  
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import Foundation
import Combine

public final class EventNavigationModel {
    public var activateSuccessSubject: PassthroughSubject<Bool, Never>
    public var model: EventModel
    
    public init(activateSuccessSubject: PassthroughSubject<Bool, Never>, model: EventModel) {
        self.activateSuccessSubject = activateSuccessSubject
        self.model = model
    }
}
