//
//  FilterViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import UIKit
import TrackerProViewModel
import SnapKit
import StoreKit

class FilterViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let headerImage = UIImageView(image: .init(named: "filterHeader"))
    private let bottomView = UIView()
    private let header = UILabel(text: "Be always informed",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let descriptionLabel = UILabel(text: "Don't miss anything important.",
                                           textColor: .white.withAlphaComponent(0.2),
                                      font: UIFont(name: "SFProText-Regular", size: 17))
    private let nextButton = UIButton(type: .system)
    private var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#021F48")
        self.view.backgroundColor = UIColor(hex: "#001724")

        self.bottomView.layer.borderWidth = 1
        self.bottomView.layer.borderColor = UIColor.white.cgColor
        self.bottomView.backgroundColor = UIColor(hex: "#001724")

        header.textAlignment = .center
        header.numberOfLines = 2

        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 2

        self.nextButton.setTitle("Next", for: .normal)
        self.nextButton.layer.cornerRadius = 25
        self.nextButton.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)
        self.nextButton.setTitleColor(.white, for: .normal)
        self.nextButton.backgroundColor = UIColor(hex: "#00A2FF")

        self.view.addSubview(bottomView)
        self.view.addSubview(headerImage)
        self.view.addSubview(header)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(nextButton)
        self.setupConstraints()
        self.setupNavigationItems()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {

        bottomView.snp.makeConstraints { view in
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(294)
        }

        headerImage.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalTo(bottomView.snp.top)
        }

        header.snp.makeConstraints { view in
            view.top.equalTo(bottomView.snp.top).offset(43)
            view.leading.equalToSuperview().offset(24)
            view.trailing.equalToSuperview().inset(24)
            view.height.equalTo(34)
        }

        descriptionLabel.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(24)
            view.trailing.equalToSuperview().inset(24)
            view.height.equalTo(20)
        }

        nextButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(70)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }
    }

}

//MARK: Make buttons actions
extension FilterViewController {
    
    private func makeButtonsAction() {
        nextButton.addTarget(self, action: #selector(nextButtonTaped), for: .touchUpInside)
    }

    private func setupNavigationItems() {
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .done, target: self, action: #selector(closeTapped))
        navigationItem.rightBarButtonItem = closeButton
    }

    @objc func nextButtonTaped() {
        guard let navigationController = self.navigationController else { return }
        let alertController = UIAlertController(title: "Notifications Enabled",
                                                message: "You will now receive notifications.",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            FilterRouter.showProfileViewController(in: navigationController)
        }
        alertController.addAction(okAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }

    @objc func closeTapped() {
        guard let navigationController = self.navigationController else { return }
        let alertController = UIAlertController(title: "Notifications Disabled",
                                                message: "You will now disable notifications.",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            FilterRouter.showProfileViewController(in: navigationController)
        }
        alertController.addAction(okAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
}

extension FilterViewController: IViewModelableController {
    typealias ViewModel = IFilterViewModel
}


//MARK: Preview
import SwiftUI

struct FilterViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let filterViewController = FilterViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<FilterViewControllerProvider.ContainerView>) -> FilterViewController {
            return filterViewController
        }

        func updateUIViewController(_ uiViewController: FilterViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<FilterViewControllerProvider.ContainerView>) {
        }
    }
}
