//
//  DetailService.swift
//  
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import UIKit
import TrackerProModel

public protocol IDetailService {
    func getDetailsItems() -> [DetailModel]
}

public class DetailService: IDetailService {
    public init() { }

    public func getDetailsItems() -> [DetailModel] {
        [
            DetailModel(image: "detailsFirst",
                        header: "Who will win? Decide and earn!",
                        description: ""),
            DetailModel(image: "detailsSecond",
                        header: "Rate our app in the AppStore",
                        description: "Help make the app even better")
        ]
    }
}
