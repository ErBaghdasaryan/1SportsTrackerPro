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

    private let pageTitle = UILabel(text: "Dashboard",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Bold", size: 28))
    private let monthly = UILabel(text: "Monthly statistics",
                                  textColor: .white,
                                  font: UIFont(name: "SFProText-Regular", size: 22))
    private let victories = StatView(title: "Victories", image: "victories")
    private let defeat = StatView(title: "Defeat", image: "defeat")
    private var firstStack: UIStackView!
    private let drawnGames = StatView(title: "Drawn games", image: "drawnG")
    private let scores = StatView(title: "Goal score", image: "goalS")
    private var secondStack: UIStackView!
    private let bestPlayer = BestPView()
    private let allStat = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#001724")

        self.pageTitle.textAlignment = .left
        self.monthly.textAlignment = .left

        self.firstStack = UIStackView(arrangedSubviews: [victories, defeat],
                                      axis: .horizontal,
                                      spacing: 8)
        self.secondStack = UIStackView(arrangedSubviews: [drawnGames, scores],
                                      axis: .horizontal,
                                      spacing: 8)

        self.allStat.setTitle("All stats", for: .normal)
        self.allStat.setTitleColor(.white, for: .normal)
        self.allStat.backgroundColor = UIColor(hex: "#00A2FF")
        self.allStat.layer.cornerRadius = 25

        self.view.addSubview(pageTitle)
        self.view.addSubview(monthly)
        self.view.addSubview(firstStack)
        self.view.addSubview(secondStack)
        self.view.addSubview(bestPlayer)
        self.view.addSubview(allStat)
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

        monthly.snp.makeConstraints { view in
            view.top.equalTo(pageTitle.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(28)
        }

        firstStack.snp.makeConstraints { view in
            view.top.equalTo(monthly.snp.bottom).offset(16)
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

        allStat.snp.makeConstraints { view in
            view.top.equalTo(bestPlayer.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(140.5)
            view.trailing.equalToSuperview().inset(140.5)
            view.height.equalTo(54)
        }
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
