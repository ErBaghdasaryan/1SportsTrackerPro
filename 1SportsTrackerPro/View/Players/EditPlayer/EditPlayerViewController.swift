//
//  EditPlayerViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import UIKit
import TrackerProViewModel
import SnapKit

class EditPlayerViewController: BaseViewController {

    var viewModel: ViewModel?

    private let backButton = UIButton(type: .system)
    private let header = UILabel(text: "",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let delete = UIButton(type: .system)
    private let defaultImage = AddPhotoView()

    private let howLong = EventPlayerPresentStatView(title: "How long in team")
    private let goals = EventPlayerPresentStatView(title: "Goals")
    private let assistance = EventPlayerPresentStatView(title: "Assistance")
    private let penalties = EventPlayerPresentStatView(title: "Penalty")
    private var stack: UIStackView!
    private let playerNumber = EventPlayerPresentStatView(title: "Player number")

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let model = self.viewModel?.player else { return }

        self.header.text = model.name
        self.defaultImage.setup(with: model.image)
        self.howLong.setup(with: model.howLong)
        self.goals.setup(with: model.goals)
        self.assistance.setup(with: model.assistance)
        self.penalties.setup(with: model.penalties)
        self.playerNumber.setup(with: model.playerNumber)

        self.goals.count.textColor = UIColor(hex: "#40D665")
        self.assistance.count.textColor = UIColor(hex: "#00A2FF")
        self.penalties.count.textColor = UIColor(hex: "#FC424B")
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#001724")

        self.backButton.setImage(UIImage(named: "back"), for: .normal)
        self.header.textAlignment = .left

        self.delete.setImage(UIImage(systemName: "trash.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.delete.tintColor = UIColor(hex: "#FC424B")

        self.defaultImage.layer.masksToBounds = true
        self.defaultImage.layer.cornerRadius = 10

        self.stack = UIStackView(arrangedSubviews: [goals, assistance, penalties],
                                 axis: .horizontal,
                                 spacing: 8)

        self.view.addSubview(backButton)
        self.view.addSubview(header)
        self.view.addSubview(delete)
        self.view.addSubview(defaultImage)
        self.view.addSubview(howLong)
        self.view.addSubview(stack)
        self.view.addSubview(playerNumber)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {
        backButton.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(166)
            view.leading.equalToSuperview().offset(16)
            view.height.equalTo(32)
            view.width.equalTo(32)
        }

        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(166)
            view.leading.equalTo(backButton.snp.trailing).offset(8)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(32)
        }

        delete.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(166)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(32)
            view.width.equalTo(32)
        }

        defaultImage.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(128)
            view.height.equalTo(128)
        }

        howLong.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalTo(defaultImage.snp.trailing).offset(8)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(128)
        }

        stack.snp.makeConstraints { view in
            view.top.equalTo(defaultImage.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(96)
        }

        playerNumber.snp.makeConstraints { view in
            view.top.equalTo(stack.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(96)
        }
    }
}


extension EditPlayerViewController: IViewModelableController {
    typealias ViewModel = IEditPlayerViewModel
}

//MARK: Progress View
extension EditPlayerViewController {
    private func makeButtonActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        delete.addTarget(self, action: #selector(deleteTeam), for: .touchUpInside)
    }

    @objc func deleteTeam() {
        guard let navigationController = self.navigationController else { return }
        guard let id = self.viewModel?.player.id else { return }

        self.viewModel?.deletePlayer(by: id)
        PlayersRouter.popViewController(in: navigationController)
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }
        PlayersRouter.popViewController(in: navigationController)
    }
}

//MARK: Preview
import SwiftUI

struct EditPlayerViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let editPlayerViewController = EditPlayerViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<EditPlayerViewControllerProvider.ContainerView>) -> EditPlayerViewController {
            return editPlayerViewController
        }

        func updateUIViewController(_ uiViewController: EditPlayerViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<EditPlayerViewControllerProvider.ContainerView>) {
        }
    }
}
