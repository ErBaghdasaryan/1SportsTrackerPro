//
//  EventViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import UIKit
import TrackerProViewModel
import SnapKit

class EventViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func setupUI() {
        super.setupUI()

        self.title = "Event"
        self.view.backgroundColor = UIColor(hex: "#001724")

        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()

    }

    func setupConstraints() {

    }
}


extension EventViewController: IViewModelableController {
    typealias ViewModel = IEventViewModel
}

//MARK: Progress View
extension EventViewController {
    private func makeButtonActions() {
        
    }
}

//MARK: Preview
import SwiftUI

struct EventViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let eventViewController = EventViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<EventViewControllerProvider.ContainerView>) -> EventViewController {
            return eventViewController
        }

        func updateUIViewController(_ uiViewController: EventViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<EventViewControllerProvider.ContainerView>) {
        }
    }
}
