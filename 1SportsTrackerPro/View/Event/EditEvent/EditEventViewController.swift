//
//  EditEventViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import UIKit
import TrackerProViewModel
import SnapKit

class EditEventViewController: BaseViewController {

    var viewModel: ViewModel?

    private let backButton = UIButton(type: .system)
    private let header = UILabel(text: "",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let delete = UIButton(type: .system)
    private let defaultImage = AddPhotoView()

    private let startAt = EventPlayerPresentStatView(title: "Start at")
    private let date = EventPlayerPresentStatView(title: "Date")

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let model = self.viewModel?.event else { return }

        self.header.text = model.name
        self.defaultImage.setup(with: model.image)
        self.startAt.setup(with: model.startTime)
        self.date.setup(with: model.date)
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
        self.view.addSubview(startAt)
        self.view.addSubview(date)
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

        startAt.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalTo(defaultImage.snp.trailing).offset(8)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(128)
        }

        date.snp.makeConstraints { view in
            view.top.equalTo(defaultImage.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(84)
        }
    }
}


extension EditEventViewController: IViewModelableController {
    typealias ViewModel = IEditEventViewModel
}

//MARK: Progress View
extension EditEventViewController {
    private func makeButtonActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        delete.addTarget(self, action: #selector(deleteTeam), for: .touchUpInside)
    }

    @objc func deleteTeam() {
        guard let navigationController = self.navigationController else { return }
        guard let id = self.viewModel?.event.id else { return }

        self.viewModel?.deleteEvent(by: id)
        EventRouter.popViewController(in: navigationController)
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }
        EventRouter.popViewController(in: navigationController)
    }
}

//MARK: Preview
import SwiftUI

struct EditEventViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let editEventViewController = EditEventViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<EditEventViewControllerProvider.ContainerView>) -> EditEventViewController {
            return editEventViewController
        }

        func updateUIViewController(_ uiViewController: EditEventViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<EditEventViewControllerProvider.ContainerView>) {
        }
    }
}
