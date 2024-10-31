//
//  AddMatchViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import UIKit
import TrackerProViewModel
import SnapKit

class AddMatchViewController: BaseViewController {

    var viewModel: ViewModel?

    private let backButton = UIButton(type: .system)
    private let header = UILabel(text: "Match",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))

    private let errorLabel = UILabel(text: "Add teams before going here!",
                                     textColor: UIColor(hex: "#FC424B")!,
                                     font: UIFont(name: "SFProText-Semibold", size: 20))
    private let createMatch = CreateMatchView()
    private let duration = CreateStatView(title: "Match duration",
                                          image: "duration",
                                          placeholder: "00:00")
    private let penalties = CreateStatView(title: "Penalties",
                                          image: "penalties",
                                          placeholder: "0")
    private let bestPlayer = CreateBestPlayerView()
    private var stack: UIStackView!

    private let create = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let name: String? = self.viewModel?.appStorageService.getData(key: .teamName)
        let imageData: Data? = self.viewModel?.appStorageService.getData(key: .teamImage)

        if let name = name, let imageData = imageData, let image = UIImage(data: imageData) {
            self.createMatch.setup(firstImage: image, firstName: name, isWin: false)
            self.errorLabel.isHidden = true
        } else {
            self.errorLabel.isHidden = false
        }
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#001724")

        self.backButton.setImage(UIImage(named: "back"), for: .normal)
        self.header.textAlignment = .left

        self.stack = UIStackView(arrangedSubviews: [duration, penalties],
                                 axis: .horizontal,
                                 spacing: 8)

        self.errorLabel.numberOfLines = 2

        self.create.setTitle("Add match", for: .normal)
        self.create.setTitleColor(.white, for: .normal)
        self.create.backgroundColor = UIColor(hex: "#00A2FF")
        self.create.layer.cornerRadius = 25

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification(_:)),
            name: Notification.Name("OpponentInfo"),
            object: nil
        )

        self.view.addSubview(backButton)
        self.view.addSubview(header)
        self.view.addSubview(errorLabel)
        self.view.addSubview(createMatch)
        self.view.addSubview(stack)
        self.view.addSubview(bestPlayer)
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

        errorLabel.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(150)
        }

        createMatch.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(150)
        }

        stack.snp.makeConstraints { view in
            view.top.equalTo(createMatch.snp.bottom).offset(16)
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

        create.snp.makeConstraints { view in
            view.top.equalTo(bestPlayer.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(124)
            view.trailing.equalToSuperview().inset(124)
            view.height.equalTo(54)
        }
    }
}


extension AddMatchViewController: IViewModelableController {
    typealias ViewModel = IAddMatchViewModel
}

//MARK: Progress View
extension AddMatchViewController {
    private func makeButtonActions() {
        create.addTarget(self, action: #selector(createTeam), for: .touchUpInside)
        createMatch.addImage.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }
        MatchRouter.popViewController(in: navigationController)
    }

    @objc private func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo,
           let text = userInfo["text"] as? String,
           let image = userInfo["image"] as? UIImage {
            self.createMatch.secondImage.setup(with: image)
            self.createMatch.secondName.text = text
        }
    }

    @objc func addImage() {
        guard let navigationController = self.navigationController else { return }
        AddMatchRouter.showSelectTeamViewController(in: navigationController)
    }

    @objc func createTeam() {
        guard let navigationController = self.navigationController else { return }
        guard let firstImage = self.createMatch.firstImage.image else { return }
        guard let firstName = self.createMatch.firstName.text  else { return }
        guard let secondImage = self.createMatch.secondImage.image.image else { return }
        guard let secondName = self.createMatch.secondName.text  else { return }
        guard let firstScore = self.createMatch.firstScore.text  else { return }
        guard let secondScore = self.createMatch.secondScore.text  else { return }
        guard let date = self.createMatch.date.text  else { return }
        guard let city = self.createMatch.city.text  else { return }
        guard let duration = self.duration.count.text else { return }
        guard let penalties = self.penalties.count.text else { return }
        guard let bpName = self.bestPlayer.name.text else { return }
        guard let bpNumber = self.bestPlayer.count.text else { return }

        var isVictory: Bool = false

        if let first = Int(firstScore), let second = Int(secondScore) {
            if first > second {
                isVictory = true
            } else {
                isVictory = false
            }
        }
        

        self.viewModel?.addMatch(model: .init(firstName: firstName,
                                              firstImage: firstImage,
                                              firstScore: firstScore,
                                              secondName: secondName,
                                              secondImage: secondImage,
                                              secondScore: secondScore,
                                              date: date,
                                              city: city,
                                              duration: duration,
                                              penalties: penalties,
                                              playerName: bpName,
                                              playerNumber: bpNumber,
                                              isVictory: isVictory))

        MatchRouter.popViewController(in: navigationController)
    }
}

//MARK: UIGesture & cell's touches
extension AddMatchViewController: UITextFieldDelegate {

    private func setupTextFieldDelegates() {
        self.createMatch.date.delegate = self
        self.createMatch.firstScore.delegate = self
        self.createMatch.secondScore.delegate = self
        self.createMatch.city.delegate = self
        self.duration.count.delegate = self
        self.penalties.count.delegate = self
        self.bestPlayer.count.delegate = self
        self.bestPlayer.name.delegate = self

        self.penalties.count.keyboardType = .numberPad
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.createMatch.date:
            textFieldDidEndEditing(textField)
            self.createMatch.firstScore.becomeFirstResponder()
        case self.createMatch.firstScore:
            textFieldDidEndEditing(textField)
            self.createMatch.secondScore.becomeFirstResponder()
        case self.createMatch.secondScore:
            textFieldDidEndEditing(textField)
            self.createMatch.city.becomeFirstResponder()
        case self.createMatch.city:
            textFieldDidEndEditing(textField)
            self.duration.count.becomeFirstResponder()
        case self.duration.count:
            textFieldDidEndEditing(textField)
            self.penalties.count.becomeFirstResponder()
        case self.penalties.count:
            textFieldDidEndEditing(textField)
            self.bestPlayer.count.becomeFirstResponder()
        case self.bestPlayer.count:
            textFieldDidEndEditing(textField)
            self.bestPlayer.name.becomeFirstResponder()
        case self.bestPlayer.name:
            textFieldDidEndEditing(textField)
            self.bestPlayer.name.resignFirstResponder()
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
        guard let date = self.createMatch.date.text else { return true }
        guard let firstS = self.createMatch.firstScore.text else { return true }
        guard let secondS = self.createMatch.secondScore.text else { return true }
        guard let city = self.createMatch.city.text else { return true }
        guard let duration = self.duration.count.text else { return true }
        guard let penalties = self.penalties.count.text else { return true }
        guard let bestPlayerNumber = self.bestPlayer.count.text else { return true }
        guard let bestPlayerName = self.bestPlayer.name.text else { return true }

        return date.isEmpty || firstS.isEmpty || secondS.isEmpty || city.isEmpty || duration.isEmpty || penalties.isEmpty || bestPlayerNumber.isEmpty || bestPlayerName.isEmpty
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

struct AddMatchViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let addMatchViewController = AddMatchViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AddMatchViewControllerProvider.ContainerView>) -> AddMatchViewController {
            return addMatchViewController
        }

        func updateUIViewController(_ uiViewController: AddMatchViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AddMatchViewControllerProvider.ContainerView>) {
        }
    }
}
