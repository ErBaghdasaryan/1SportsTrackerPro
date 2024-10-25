//
//  UIDevice.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 25.10.24.
//

import UIKit

enum DeviceType {
    case iPhone
    case iPad
}

extension UIDevice {
    static var currentDeviceType: DeviceType {
        return UIDevice.current.userInterfaceIdiom == .pad ? .iPad : .iPhone
    }
}
