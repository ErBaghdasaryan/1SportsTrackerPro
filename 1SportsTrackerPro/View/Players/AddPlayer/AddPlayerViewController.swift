//
//  AddPlayerViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import UIKit
import TrackerProViewModel
import SnapKit

class AddPlayerViewController: BaseViewController {

    var viewModel: ViewModel?

    private let backButton = UIButton(type: .system)
    private let header = HeaderTextField(placeholder: "Player name")

    private let defaultImage = AddPhotoView()
    private let addImage = UIButton(type: .system)
    private var selectedImage: UIImage?

    private let howLong = EventPlayerStatView(title: "How long in team",
                                              placeholder: "-")
    private let goals = EventPlayerStatView(title: "Goals",
                                           placeholder: "-")
    private let assistance = EventPlayerStatView(title: "Assistance",
                                           placeholder: "-")
    private let penalties = EventPlayerStatView(title: "Penalty",
                                           placeholder: "-")
    private var stack: UIStackView!
    private let playerNumber = EventPlayerStatView(title: "Player number",
                                           placeholder: "-")

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

        self.create.setTitle("Create player profile", for: .normal)
        self.create.setTitleColor(.white, for: .normal)
        self.create.backgroundColor = UIColor(hex: "#00A2FF")
        self.create.layer.cornerRadius = 25

        self.defaultImage.layer.masksToBounds = true
        self.defaultImage.layer.cornerRadius = 10

        self.stack = UIStackView(arrangedSubviews: [goals, assistance, penalties],
                                 axis: .horizontal,
                                 spacing: 8)

        self.view.addSubview(backButton)
        self.view.addSubview(header)
        self.view.addSubview(defaultImage)
        self.view.addSubview(addImage)
        self.view.addSubview(howLong)
        self.view.addSubview(stack)
        self.view.addSubview(playerNumber)
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

        create.snp.makeConstraints { view in
            view.top.equalTo(playerNumber.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(93)
            view.trailing.equalToSuperview().inset(93)
            view.height.equalTo(54)
        }
    }
}


extension AddPlayerViewController: IViewModelableController {
    typealias ViewModel = IAddPlayerViewModel
}

//MARK: Progress View
extension AddPlayerViewController {
    private func makeButtonActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        addImage.addTarget(self, action: #selector(addImageTapped), for: .touchUpInside)
        create.addTarget(self, action: #selector(createTeam), for: .touchUpInside)
    }

    @objc func createTeam() {
        guard let navigationController = self.navigationController else { return }
        guard let name = self.header.text else { return }
        guard let image = self.selectedImage else { return }
        guard let howLong = self.howLong.count.text else { return }
        guard let goals = self.goals.count.text else { return }
        guard let assists = self.assistance.count.text else { return }
        guard let penalties = self.penalties.count.text else { return }
        guard let playerNumber = self.playerNumber.count.text else { return }

        self.viewModel?.addPlayer(model: .init(image: image,
                                               name: name,
                                               howLong: howLong,
                                               goals: goals,
                                               assistance: assists,
                                               penalties: penalties,
                                               playerNumber: playerNumber))

        PlayersRouter.popViewController(in: navigationController)
    }

    @objc func addImageTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true)
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }
        PlayersRouter.popViewController(in: navigationController)
    }
}

//MARK: Image Picker
extension AddPlayerViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        self.defaultImage.setup(with: image)
        selectedImage = image
    }
}

//MARK: UIGesture & cell's touches
extension AddPlayerViewController: UITextFieldDelegate {

    private func setupTextFieldDelegates() {
        self.header.delegate = self
        self.howLong.count.delegate = self
        self.goals.count.delegate = self
        self.assistance.count.delegate = self
        self.penalties.count.delegate = self
        self.playerNumber.count.delegate = self

        howLong.count.keyboardType = .numberPad
        goals.count.keyboardType = .numberPad
        assistance.count.keyboardType = .numberPad
        penalties.count.keyboardType = .numberPad
        playerNumber.count.keyboardType = .numberPad
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.header:
            textFieldDidEndEditing(textField)
            self.howLong.count.becomeFirstResponder()
        case self.howLong.count:
            textFieldDidEndEditing(textField)
            self.goals.count.becomeFirstResponder()
        case self.goals.count:
            textFieldDidEndEditing(textField)
            self.assistance.count.becomeFirstResponder()
        case self.assistance.count:
            textFieldDidEndEditing(textField)
            self.penalties.count.becomeFirstResponder()
        case self.penalties.count:
            textFieldDidEndEditing(textField)
            self.playerNumber.count.becomeFirstResponder()
        case self.playerNumber.count:
            textFieldDidEndEditing(textField)
            self.playerNumber.count.resignFirstResponder()
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
        guard let howLong = self.howLong.count.text else { return true }
        guard let goals = self.goals.count.text else { return true }
        guard let assistance = self.assistance.count.text else { return true }
        guard let penalties = self.penalties.count.text else { return true }
        guard let playerNumber = self.playerNumber.count.text else { return true }

        return name.isEmpty || howLong.isEmpty || goals.isEmpty || assistance.isEmpty || penalties.isEmpty || playerNumber.isEmpty
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

struct AddPlayerViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let addPlayerViewController = AddPlayerViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AddPlayerViewControllerProvider.ContainerView>) -> AddPlayerViewController {
            return addPlayerViewController
        }

        func updateUIViewController(_ uiViewController: AddPlayerViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AddPlayerViewControllerProvider.ContainerView>) {
        }
    }
}

