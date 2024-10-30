//
//  SubjectNavigationModel.swift
//
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import Foundation
import Combine

public final class AddNavigationModel {
    public var activateSuccessSubject: PassthroughSubject<Bool, Never>
    
    public init(activateSuccessSubject: PassthroughSubject<Bool, Never>) {
        self.activateSuccessSubject = activateSuccessSubject
    }
}
