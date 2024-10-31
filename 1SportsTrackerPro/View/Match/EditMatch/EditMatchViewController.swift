//
//  EditMatchViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import UIKit
import TrackerProViewModel
import SnapKit

class EditMatchViewController: BaseViewController {

    var viewModel: ViewModel?

    private let backButton = UIButton(type: .system)
    private let header = UILabel(text: "Match",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let delete = UIButton(type: .system)
    private let matchView = MatchPresentView()
    private let duration = StatView(title: "Match duration",
                                    image: "duration")
    private let penalties = StatView(title: "Penalties",
                                     image: "penalties")
    private let bestPlayer = BestPView()
    private var stack: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let model = self.viewModel?.match else { return }

        self.matchView.setup(model: model)
        self.duration.setup(with: model.duration)
        self.penalties.setup(with: model.penalties)
        self.bestPlayer.setup(with: model.playerNumber, and: model.playerName)
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#001724")

        self.backButton.setImage(UIImage(named: "back"), for: .normal)
        self.header.textAlignment = .left

        self.delete.setImage(UIImage(systemName: "trash.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.delete.tintColor = UIColor(hex: "#FC424B")

        self.stack = UIStackView(arrangedSubviews: [duration, penalties],
                                 axis: .horizontal,
                                 spacing: 8)

        self.view.addSubview(backButton)
        self.view.addSubview(header)
        self.view.addSubview(delete)
        self.view.addSubview(matchView)
        self.view.addSubview(stack)
        self.view.addSubview(bestPlayer)
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

        matchView.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(150)
        }

        stack.snp.makeConstraints { view in
            view.top.equalTo(matchView.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(96)
        }

        bestPlayer.snp.makeConstraints { view in
            view.top.equalTo(stack.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(96)
        }
    }
}


extension EditMatchViewController: IViewModelableController {
    typealias ViewModel = IEditMatchViewModel
}

//MARK: Progress View
extension EditMatchViewController {
    private func makeButtonActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        delete.addTarget(self, action: #selector(deleteTeam), for: .touchUpInside)
    }

    @objc func deleteTeam() {
        guard let navigationController = self.navigationController else { return }
        guard let id = self.viewModel?.match.id else { return }

        self.viewModel?.deleteMatch(by: id)
        MatchRouter.popViewController(in: navigationController)
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }
        MatchRouter.popViewController(in: navigationController)
    }
}

//MARK: Preview
import SwiftUI

struct EditMatchViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let editMatchViewController = EditMatchViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<EditMatchViewControllerProvider.ContainerView>) -> EditMatchViewController {
            return editMatchViewController
        }

        func updateUIViewController(_ uiViewController: EditMatchViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<EditMatchViewControllerProvider.ContainerView>) {
        }
    }
}
