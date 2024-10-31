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

    private let pageTitle = UILabel(text: "Events",
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

        tableView.contentInset = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0    )
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false

        self.tableView.register(EmptyTableViewCell.self)
        self.tableView.register(EventTableViewCell.self)
    }
}


extension EventViewController: IViewModelableController {
    typealias ViewModel = IEventViewModel
}

//MARK: Progress View
extension EventViewController {
    private func makeButtonActions() {
        self.add.addTarget(self, action: #selector(addEvent), for: .touchUpInside)
    }

    @objc func addEvent() {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }
        EventRouter.showAddEventViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject))
    }

    private func editEvent(for index: Int) {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        let model = self.viewModel?.events[index]

        EventRouter.showEditEventViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject, model: model!))
    }
}

//MARK: TableView Delegate & Data source
extension EventViewController:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel?.events.count ?? 0
        return count == 0 ? 1 : count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel?.events.isEmpty ?? true {
            let cell: EmptyTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(with: "There are no events yet", and: UIImage(named: "events")!)
            return cell
        } else {
            let cell: EventTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            if let model = viewModel?.events[indexPath.row] {
                cell.setup(model: model)
            }

            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel?.events.isEmpty ?? true {
            return 48
        } else {
            return 134
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.editEvent(for: indexPath.row)
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
