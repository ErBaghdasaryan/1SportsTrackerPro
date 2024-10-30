//
//  AddTeamViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import UIKit
import TrackerProViewModel
import SnapKit

class AddTeamViewController: BaseViewController {

    var viewModel: ViewModel?

    private let backButton = UIButton(type: .system)
    private let header = HeaderTextField(placeholder: "Team name")

    private let defaultImage = AddPhotoView()
    private let addImage = UIButton(type: .system)
    private var selectedImage: UIImage?

    private let create = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#001724")

        self.backButton.setImage(UIImage(named: "back"), for: .normal)
        self.header.textAlignment = .left

        self.create.setTitle("Create team", for: .normal)
        self.create.setTitleColor(.white, for: .normal)
        self.create.backgroundColor = UIColor(hex: "#00A2FF")
        self.create.layer.cornerRadius = 25

        self.view.addSubview(backButton)
        self.view.addSubview(header)
        self.view.addSubview(defaultImage)
        self.view.addSubview(addImage)
        self.view.addSubview(create)
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

        defaultImage.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.centerX.equalToSuperview()
            view.width.equalTo(128)
            view.height.equalTo(128)
        }

        addImage.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.centerX.equalToSuperview()
            view.width.equalTo(128)
            view.height.equalTo(128)
        }

        create.snp.makeConstraints { view in
            view.top.equalTo(defaultImage.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(124)
            view.trailing.equalToSuperview().inset(124)
            view.height.equalTo(54)
        }
    }
}


extension AddTeamViewController: IViewModelableController {
    typealias ViewModel = IAddTeamViewModel
}

//MARK: Progress View
extension AddTeamViewController {
    private func makeButtonActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        addImage.addTarget(self, action: #selector(addImageTapped), for: .touchUpInside)
        create.addTarget(self, action: #selector(createTeam), for: .touchUpInside)
    }

    @objc func createTeam() {
        guard let navigationController = self.navigationController else { return }
        guard let name = self.header.text else { return }
        guard let image = self.selectedImage else { return }

        self.viewModel?.addTeam(model: .init(image: image,
                                             title: name))

        TeamRouter.popViewController(in: navigationController)
    }

    @objc func addImageTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true)
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }
        TabBarRouter.popViewController(in: navigationController)
    }
}

//MARK: Image Picker
extension AddTeamViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        self.defaultImage.setup(with: image)
        selectedImage = image
    }
}

//MARK: Preview
import SwiftUI

struct AddTeamViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let addTeamViewController = AddTeamViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AddTeamViewControllerProvider.ContainerView>) -> AddTeamViewController {
            return addTeamViewController
        }

        func updateUIViewController(_ uiViewController: AddTeamViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AddTeamViewControllerProvider.ContainerView>) {
        }
    }
}

