//
//  DashboardViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import UIKit
import TrackerProViewModel
import SnapKit

class DashboardViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func setupUI() {
        super.setupUI()

        self.title = "Dashboard"
        self.view.backgroundColor = UIColor(hex: "#001724")

        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()

    }

    func setupConstraints() {

    }
}


extension DashboardViewController: IViewModelableController {
    typealias ViewModel = IDashboardViewModel
}

//MARK: Progress View
extension DashboardViewController {
    private func makeButtonActions() {
        
    }
}

//MARK: Preview
import SwiftUI

struct DashboardViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let dashboardViewController = DashboardViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<DashboardViewControllerProvider.ContainerView>) -> DashboardViewController {
            return dashboardViewController
        }

        func updateUIViewController(_ uiViewController: DashboardViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<DashboardViewControllerProvider.ContainerView>) {
        }
    }
}
