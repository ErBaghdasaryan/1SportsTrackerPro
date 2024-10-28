//
//  PlayersViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import UIKit
import TrackerProViewModel
import SnapKit

class PlayersViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func setupUI() {
        super.setupUI()

        self.title = "Players"
        self.view.backgroundColor = UIColor(hex: "#001724")

        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()

    }

    func setupConstraints() {

    }
}


extension PlayersViewController: IViewModelableController {
    typealias ViewModel = IPlayersViewModel
}

//MARK: Progress View
extension PlayersViewController {
    private func makeButtonActions() {
        
    }
}

//MARK: Preview
import SwiftUI

struct PlayersViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let playersViewController = PlayersViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<PlayersViewControllerProvider.ContainerView>) -> PlayersViewController {
            return playersViewController
        }

        func updateUIViewController(_ uiViewController: PlayersViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<PlayersViewControllerProvider.ContainerView>) {
        }
    }
}
