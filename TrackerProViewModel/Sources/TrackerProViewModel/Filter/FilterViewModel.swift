//
//  FilterViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import Foundation
import TrackerProModel

public protocol IFilterViewModel {

}

public class FilterViewModel: IFilterViewModel {

    private let filterService: IFilterService

    public init(filterService: IFilterService) {
        self.filterService = filterService
    }
}
