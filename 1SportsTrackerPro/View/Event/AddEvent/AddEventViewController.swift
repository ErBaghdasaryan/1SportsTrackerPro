//
//  AddEventViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import UIKit
import TrackerProViewModel
import SnapKit

class AddEventViewController: BaseViewController {

    var viewModel: ViewModel?

    private let backButton = UIButton(type: .system)
    private let header = HeaderTextField(placeholder: "Event name")

    private let defaultImage = AddPhotoView()
    private let addImage = UIButton(type: .system)
    private var selectedImage: UIImage?

    private let startAt = EventPlayerStatView(title: "Start at",
                                              placeholder: "00:00")
    private let date = EventPlayerStatView(title: "Date",
                                           placeholder: "DD MM YYYY")

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

        self.create.setTitle("Create event", for: .normal)
        self.create.setTitleColor(.white, for: .normal)
        self.create.backgroundColor = UIColor(hex: "#00A2FF")
        self.create.layer.cornerRadius = 25

        self.view.addSubview(backButton)
        self.view.addSubview(header)
        self.view.addSubview(defaultImage)
        self.view.addSubview(addImage)
        self.view.addSubview(startAt)
        self.view.addSubview(date)
        self.view.addSubview(create)
        setupConstraints()
        setupTextFieldDelegates()
        setupViewTapHandling()
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

        defaultImage.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(128)
            view.height.equalTo(128)
        }

        addImage.snp.makeConstraints { view in
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

        create.snp.makeConstraints { view in
            view.top.equalTo(date.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(124)
            view.trailing.equalToSuperview().inset(124)
            view.height.equalTo(54)
        }
    }
}


extension AddEventViewController: IViewModelableController {
    typealias ViewModel = IAddEventViewModel
}

//MARK: Progress View
extension AddEventViewController {
    private func makeButtonActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        addImage.addTarget(self, action: #selector(addImageTapped), for: .touchUpInside)
        create.addTarget(self, action: #selector(createTeam), for: .touchUpInside)
    }

    @objc func createTeam() {
        guard let navigationController = self.navigationController else { return }
        guard let name = self.header.text else { return }
        guard let image = self.selectedImage else { return }
        guard let startAt = self.startAt.count.text else { return }
        guard let date = self.date.count.text else { return }

        self.viewModel?.addEvent(model: .init(name: name,
                                              image: image,
                                              startTime: startAt,
                                              date: date))

        EventRouter.popViewController(in: navigationController)
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
extension AddEventViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        self.defaultImage.setup(with: image)
        selectedImage = image
    }
}

//MARK: UIGesture & cell's touches
extension AddEventViewController: UITextFieldDelegate {

    private func setupTextFieldDelegates() {
        self.header.delegate = self
        self.startAt.count.delegate = self
        self.date.count.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.header:
            textFieldDidEndEditing(textField)
            self.startAt.count.becomeFirstResponder()
        case self.startAt.count:
            textFieldDidEndEditing(textField)
            self.date.count.becomeFirstResponder()
        case self.date.count:
            textFieldDidEndEditing(textField)
            self.date.count.resignFirstResponder()
        default:
            break
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateButtonBackgroundColor()
    }

    private func updateButtonBackgroundColor() {
        let allFieldsFilled = !checkAllFields()
        self.create.isUserInteractionEnabled = allFieldsFilled ? true : false
    }

    private func checkAllFields() -> Bool {
        guard let name = self.header.text else { return true }
        guard let startAt = self.startAt.count.text else { return true }
        guard let date = self.date.count.text else { return true }

        return name.isEmpty || startAt.isEmpty || date.isEmpty
    }

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    private func setupViewTapHandling() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
}

//MARK: Preview
import SwiftUI

struct AddEventViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let addEventViewController = AddEventViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AddEventViewControllerProvider.ContainerView>) -> AddEventViewController {
            return addEventViewController
        }

        func updateUIViewController(_ uiViewController: AddEventViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AddEventViewControllerProvider.ContainerView>) {
        }
    }
}
