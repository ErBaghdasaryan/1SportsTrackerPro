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

    private let pageTitle = UILabel(text: "Stats",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Bold", size: 28))
    private let victories = StatView(title: "Victories", image: "victories")
    private let defeat = StatView(title: "Defeat", image: "defeat")
    private var firstStack: UIStackView!
    private let drawnGames = StatView(title: "Drawn games", image: "drawnG")
    private let scores = StatView(title: "Goal score", image: "goalS")
    private var secondStack: UIStackView!
    private let bestPlayer = BestPView()
    private let winsPersintage = StatView(title: "Wins percentage",
                                          image: "winPercintage",
                                          isWinsPersintage: true)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#001724")

        self.pageTitle.textAlignment = .left

        self.firstStack = UIStackView(arrangedSubviews: [victories, defeat],
                                      axis: .horizontal,
                                      spacing: 8)
        self.secondStack = UIStackView(arrangedSubviews: [drawnGames, scores],
                                      axis: .horizontal,
                                      spacing: 8)

        self.view.addSubview(pageTitle)
        self.view.addSubview(firstStack)
        self.view.addSubview(secondStack)
        self.view.addSubview(bestPlayer)
        self.view.addSubview(winsPersintage)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()

    }

    func setupConstraints() {
        pageTitle.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(166)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }

        firstStack.snp.makeConstraints { view in
            view.top.equalTo(pageTitle.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(96)
        }

        secondStack.snp.makeConstraints { view in
            view.top.equalTo(firstStack.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(96)
        }

        bestPlayer.snp.makeConstraints { view in
            view.top.equalTo(secondStack.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(96)
        }

        winsPersintage.snp.makeConstraints { view in
            view.top.equalTo(bestPlayer.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(96)
        }
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
