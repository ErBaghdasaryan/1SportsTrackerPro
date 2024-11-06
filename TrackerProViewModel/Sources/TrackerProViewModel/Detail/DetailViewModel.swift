//
//  DetailViewModel.swift
//
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import Foundation
import TrackerProModel

public protocol IDetailViewModel {
    var detailsItems: [DetailModel] { get set }
    func loadData()
}

public class DetailViewModel: IDetailViewModel {

    private let detailService: IDetailService

    public var detailsItems: [DetailModel] = []

    public init(detailService: IDetailService) {
        self.detailService = detailService
    }

    public func loadData() {
        detailsItems = detailService.getDetailsItems()
    }
}
