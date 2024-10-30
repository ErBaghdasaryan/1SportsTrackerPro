//
//  EventViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import Foundation
import TrackerProModel
import Combine

public protocol IEventViewModel {
    func loadData()
    var activateSuccessSubject: PassthroughSubject<Bool, Never> { get }
    var events: [EventModel] { get set }
}

public class EventViewModel: IEventViewModel {

    private let eventService: IEventService
    public var events: [EventModel] = []
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(eventService: IEventService) {
        self.eventService = eventService
    }

    public func loadData() {
        do {
            self.events = try self.eventService.getEvents()
        } catch {
            print(error)
        }
    }
}
