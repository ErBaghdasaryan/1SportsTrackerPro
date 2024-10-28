//
//  StatisticViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import UIKit
import TrackerProViewModel
import SnapKit

class StatisticViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func setupUI() {
        super.setupUI()

        self.title = "Statistic"
        self.view.backgroundColor = UIColor(hex: "#001724")

        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()

    }

    func setupConstraints() {

    }
}


extension StatisticViewController: IViewModelableController {
    typealias ViewModel = IStatisticViewModel
}

//MARK: Progress View
extension StatisticViewController {
    private func makeButtonActions() {
        
    }
}

//MARK: Preview
import SwiftUI

struct StatisticViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let statisticViewController = StatisticViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<StatisticViewControllerProvider.ContainerView>) -> StatisticViewController {
            return statisticViewController
        }

        func updateUIViewController(_ uiViewController: StatisticViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<StatisticViewControllerProvider.ContainerView>) {
        }
    }
}
