//
//  ChooseTeamViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import UIKit
import TrackerProViewModel
import TrackerProModel
import SnapKit

class ChooseTeamViewController: BaseViewController {

    var viewModel: ViewModel?

    private let backButton = UIButton(type: .system)
    private let header = UILabel(text: "Your teams",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let add = UIButton(type: .system)
    var collectionView: UICollectionView!

    private var selectedTeam: TeamModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#001724")

        self.backButton.setImage(UIImage(named: "back"), for: .normal)
        self.header.textAlignment = .left

        self.add.setImage(UIImage(named: "add"), for: .normal)

        let numberOfColumns: CGFloat = 2
        let spacing: CGFloat = 10
        let totalSpacing = ((numberOfColumns - 1) * spacing) + 10
        let availableWidth = self.view.frame.width - totalSpacing
        let itemWidth = availableWidth / numberOfColumns

        let myLayout = UICollectionViewFlowLayout()
        myLayout.itemSize = CGSize(width: itemWidth, height: 126)
        myLayout.scrollDirection = .vertical
        myLayout.minimumLineSpacing = spacing
        myLayout.minimumInteritemSpacing = spacing
        myLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: myLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(EmptyCollectionViewCell.self)
        collectionView.register(TeamCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self

        self.view.addSubview(backButton)
        self.view.addSubview(header)
        self.view.addSubview(add)
        self.view.addSubview(collectionView)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadData()
        self.collectionView.reloadData()

        viewModel?.activateSuccessSubject.sink { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.loadData()
            self.collectionView.reloadData()
        }.store(in: &cancellables)
    }

    func setupConstraints() {
        backButton.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(102)
            view.leading.equalToSuperview().offset(16)
            view.height.equalTo(32)
            view.width.equalTo(32)
        }

        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(102)
            view.leading.equalTo(backButton.snp.trailing).offset(8)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(32)
        }

        add.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(102)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(32)
            view.width.equalTo(32)
        }

        collectionView.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }
    }
}


extension ChooseTeamViewController: IViewModelableController {
    typealias ViewModel = ITeamViewModel
}

//MARK: Progress View
extension ChooseTeamViewController {
    private func makeButtonActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        add.addTarget(self, action: #selector(addTeam), for: .touchUpInside)
    }

    private func sendNotification(image: UIImage, name: String) {

        let userInfo: [String: Any] = [
            "text": name,
            "image": image as Any
        ]

        NotificationCenter.default.post(
            name: Notification.Name("TeamInfo"),
            object: nil,
            userInfo: userInfo
        )
    }


    private func editTeam(for index: Int) {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        let model = self.viewModel?.teams[index]

        TeamRouter.showEditTeamViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject, model: model!))
    }

    @objc func addTeam() {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        TeamRouter.showAddTeamViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject))
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }
        TabBarRouter.popViewController(in: navigationController)
    }
}

extension ChooseTeamViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.viewModel?.teams.count ?? 0
        return count == 0 ? 1 : count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let count = self.viewModel?.teams.count ?? 0
        if count == 0 {
            let cell: EmptyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(with: "You haven't created any opposing teams yet",
                       and: UIImage(named: "players")!)
            return cell
        } else {
            let cell: TeamCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            if let team = self.viewModel?.teams[indexPath.row] {
                cell.setup(with: team.title, and: team.image)
            }

            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = self.viewModel?.teams.count ?? 0

        if count == 0 {
            return CGSize(width: collectionView.frame.width, height: 150)
        } else {
            let numberOfColumns: CGFloat = 2
            let spacing: CGFloat = 10

            let layout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpacing = layout.sectionInset.left + layout.sectionInset.right + ((numberOfColumns - 1) * layout.minimumInteritemSpacing)

            let availableWidth = collectionView.frame.width - totalSpacing
            let itemWidth = availableWidth / numberOfColumns

            return CGSize(width: itemWidth, height: 126)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let count = self.viewModel?.teams.count ?? 0
        if count > 0, let selectedTeam = self.viewModel?.teams[indexPath.row] {
            self.selectedTeam = selectedTeam
            sendNotification(image: selectedTeam.image, name: selectedTeam.title)
            if let cell = collectionView.cellForItem(at: indexPath) as? TeamCollectionViewCell {
                cell.setSelectedState(true)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TeamCollectionViewCell {
            cell.setSelectedState(false)
        }
    }
}



//MARK: Preview
import SwiftUI

struct ChooseTeamViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let chooseTeamViewController = ChooseTeamViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ChooseTeamViewControllerProvider.ContainerView>) -> ChooseTeamViewController {
            return chooseTeamViewController
        }

        func updateUIViewController(_ uiViewController: ChooseTeamViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ChooseTeamViewControllerProvider.ContainerView>) {
        }
    }
}
