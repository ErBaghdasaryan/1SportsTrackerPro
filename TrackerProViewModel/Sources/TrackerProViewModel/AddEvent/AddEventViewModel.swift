//
//  AddEventViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import Foundation
import TrackerProModel
import Combine

public protocol IAddEventViewModel {
    func addEvent(model: EventModel)
    var appStorageService: IAppStorageService { get set }
}

public class AddEventViewModel: IAddEventViewModel {

    private let eventService: IEventService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()
    public var appStorageService: IAppStorageService

    public init(eventService: IEventService, navigationModel: AddNavigationModel, appStorageService: IAppStorageService) {
        self.eventService = eventService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
        self.appStorageService = appStorageService
    }

    public func addEvent(model: EventModel) {
        do {
            _ = try self.eventService.addEvent(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
