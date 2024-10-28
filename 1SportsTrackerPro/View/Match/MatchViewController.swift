//
//  MatchViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import UIKit
import TrackerProViewModel
import SnapKit

class MatchViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func setupUI() {
        super.setupUI()

        self.title = "Match"
        self.view.backgroundColor = UIColor(hex: "#001724")

        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()

    }

    func setupConstraints() {

    }
}


extension MatchViewController: IViewModelableController {
    typealias ViewModel = IMatchViewModel
}

//MARK: Progress View
extension MatchViewController {
    private func makeButtonActions() {
        
    }
}

//MARK: Preview
import SwiftUI

struct MatchViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let matchViewController = MatchViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<MatchViewControllerProvider.ContainerView>) -> MatchViewController {
            return matchViewController
        }

        func updateUIViewController(_ uiViewController: MatchViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<MatchViewControllerProvider.ContainerView>) {
        }
    }
}
