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

    private let pageTitle = UILabel(text: "Players",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Bold", size: 28))
    private let add = UIButton(type: .system)
    private let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
        setupTableView()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#001724")
        self.pageTitle.textAlignment = .left
        self.add.setImage(UIImage(named: "add"), for: .normal)

        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = true

        self.view.addSubview(pageTitle)
        self.view.addSubview(add)
        self.view.addSubview(tableView)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadData()
        self.tableView.reloadData()

        viewModel?.activateSuccessSubject.sink { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.loadData()
            self.tableView.reloadData()
        }.store(in: &cancellables)
    }

    func setupConstraints() {
        pageTitle.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(166)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }

        add.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(166)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(32)
            view.width.equalTo(32)
        }

        tableView.snp.makeConstraints { view in
            view.top.equalTo(pageTitle.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false

        self.tableView.register(EmptyTableViewCell.self)
        self.tableView.register(MatchTableViewCell.self)
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

//MARK: TableView Delegate & Data source
extension PlayersViewController:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel?.players.count ?? 0
        return count == 0 ? 1 : count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel?.players.isEmpty ?? true {
            let cell: EmptyTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(with: "You don't have any team members yet", and: UIImage(named: "players")!)
            return cell
        } else {
            let cell: MatchTableViewCell = tableView.dequeueReusableCell(for: indexPath)
//            if let model = viewModel?.events[indexPath.row] {
//                cell.setup(model: model)
//            }

            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel?.players.isEmpty ?? true {
            return 48
        } else {
            return 166
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.editBet(for: indexPath.row)
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
