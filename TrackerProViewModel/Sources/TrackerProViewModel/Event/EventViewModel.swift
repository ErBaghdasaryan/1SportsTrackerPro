//
//  EventViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import Foundation
import TrackerProModel

public protocol IEventViewModel {
    
}

public class EventViewModel: IEventViewModel {

    private let eventService: IEventService

    public init(eventService: IEventService) {
        self.eventService = eventService
    }
}
