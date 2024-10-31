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

    private let scrollView = UIScrollView()
    private let contentView = UIView()

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
    private let lastMatch = UILabel(text: "Last match",
                                  textColor: .white,
                                  font: UIFont(name: "SFProText-Regular", size: 22))
    private let emptyMatch = EmptyView()
    private let lastMatchView = LastMatchView()
    private let lastEvent = UILabel(text: "Next event",
                                  textColor: .white,
                                  font: UIFont(name: "SFProText-Regular", size: 22))
    private let emptyEvent = EmptyView()
    private let lastEventView = LastEventView()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.loadMatches()
        self.viewModel?.loadEvents()

        if let match = self.viewModel?.matche {
            self.lastMatchView.setup(model: match)
            self.lastMatchView.isHidden = false
            self.emptyMatch.isHidden = true
        } else {
            self.emptyMatch.isHidden = false
            self.lastMatchView.isHidden = true
        }

        if let event = self.viewModel?.event {
            self.lastEventView.setup(model: event)
            self.lastEventView.isHidden = false
            self.emptyEvent.isHidden = true
        } else {
            self.emptyEvent.isHidden = false
            self.lastEventView.isHidden = true
        }

        guard let winCount = self.viewModel?.wonMatchesCount else { return }
        guard let lostCount = self.viewModel?.lostMatchesCount else { return }

        self.victories.setup(with: "\(winCount)")
        self.defeat.setup(with: "\(lostCount)")

        guard let playerName = viewModel?.playerName else { return }
        guard let playerNumber = viewModel?.playerNumber else { return }

        self.bestPlayer.setup(with: "\(playerNumber)", and: "\(playerName)")

        guard let totalScore = viewModel?.totalScore else { return }
        self.scores.setup(with: "\(totalScore)")

        sendNotification(victories: "\(winCount)",
                         defeat: "\(lostCount)",
                         goalScore: "\(totalScore)",
                         bpNumber: "\(playerNumber)",
                         bpName: "\(playerName)")
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#001724")

        self.pageTitle.textAlignment = .left
        self.monthly.textAlignment = .left
        self.lastMatch.textAlignment = .left
        self.lastEvent.textAlignment = .left

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

        self.emptyMatch.setup(with: "There are no matches yet",
                              and: UIImage(named: "matches")!)

        self.emptyEvent.setup(with: "There are no events yet",
                              and: UIImage(named: "events")!)

        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.contentView.addSubview(pageTitle)
        self.contentView.addSubview(monthly)
        self.contentView.addSubview(firstStack)
        self.contentView.addSubview(secondStack)
        self.contentView.addSubview(bestPlayer)
        self.contentView.addSubview(allStat)
        self.contentView.addSubview(lastMatch)
        self.contentView.addSubview(emptyMatch)
        self.contentView.addSubview(lastMatchView)
        self.contentView.addSubview(lastEvent)
        self.contentView.addSubview(emptyEvent)
        self.contentView.addSubview(lastEventView)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadMatches()
        self.viewModel?.loadEvents()
    }

    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        pageTitle.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(80)
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

        lastMatch.snp.makeConstraints { view in
            view.top.equalTo(allStat.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(28)
        }

        emptyMatch.snp.makeConstraints { view in
            view.top.equalTo(lastMatch.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(150)
        }

        lastMatchView.snp.makeConstraints { view in
            view.top.equalTo(lastMatch.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(150)
        }

        lastEvent.snp.makeConstraints { view in
            view.top.equalTo(emptyMatch.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(28)
        }

        emptyEvent.snp.makeConstraints { view in
            view.top.equalTo(lastEvent.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(126)
        }

        lastEventView.snp.makeConstraints { view in
            view.top.equalTo(lastEvent.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(126)
            view.bottom.equalToSuperview().offset(-16)
        }
    }
}


extension DashboardViewController: IViewModelableController {
    typealias ViewModel = IDashboardViewModel
}

//MARK: Progress View
extension DashboardViewController {
    private func makeButtonActions() {
        allStat.addTarget(self, action: #selector(allStatTapped), for: .touchUpInside)
    }

    @objc func allStatTapped() {
        NotificationCenter.default.post(
            name: Notification.Name("AllStatistic"),
            object: nil,
            userInfo: nil
        )
    }

    private func sendNotification(victories: String,
                                  defeat: String,
                                  goalScore: String, 
                                  bpNumber: String,
                                  bpName: String) {

        let userInfo: [String: String] = [
            "string1": victories,
            "string2": defeat,
            "string3": goalScore,
            "string4": bpNumber,
            "string5": bpName
        ]

        NotificationCenter.default.post(
            name: Notification.Name("SendStatistic"),
            object: nil,
            userInfo: userInfo
        )
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
