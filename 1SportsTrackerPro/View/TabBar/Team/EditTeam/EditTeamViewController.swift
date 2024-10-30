//
//  EditTeamViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import UIKit
import TrackerProViewModel
import SnapKit

class EditTeamViewController: BaseViewController {

    var viewModel: ViewModel?

    private let backButton = UIButton(type: .system)
    private let header = UILabel(text: "",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let delete = UIButton(type: .system)
    private let defaultImage = AddPhotoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let model = self.viewModel?.team else { return }

        self.header.text = model.title
        self.defaultImage.setup(with: model.image)
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#001724")

        self.backButton.setImage(UIImage(named: "back"), for: .normal)
        self.header.textAlignment = .left

        self.delete.setImage(UIImage(systemName: "trash.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.delete.tintColor = UIColor(hex: "#FC424B")

        self.view.addSubview(backButton)
        self.view.addSubview(header)
        self.view.addSubview(delete)
        self.view.addSubview(defaultImage)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
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

        delete.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(102)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(32)
            view.width.equalTo(32)
        }

        defaultImage.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.centerX.equalToSuperview()
            view.width.equalTo(128)
            view.height.equalTo(128)
        }
    }
}


extension EditTeamViewController: IViewModelableController {
    typealias ViewModel = IEditTeamViewModel
}

//MARK: Progress View
extension EditTeamViewController {
    private func makeButtonActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        delete.addTarget(self, action: #selector(deleteTeam), for: .touchUpInside)
    }

    @objc func deleteTeam() {
        guard let navigationController = self.navigationController else { return }
        guard let id = self.viewModel?.team.id else { return }

        self.viewModel?.deleteTeam(by: id)
        TeamRouter.popViewController(in: navigationController)
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }
        TabBarRouter.popViewController(in: navigationController)
    }
}

//MARK: Preview
import SwiftUI

struct EditTeamViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let editTeamViewController = EditTeamViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<EditTeamViewControllerProvider.ContainerView>) -> EditTeamViewController {
            return editTeamViewController
        }

        func updateUIViewController(_ uiViewController: EditTeamViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<EditTeamViewControllerProvider.ContainerView>) {
        }
    }
}
