//
//  SettingsViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 29.10.24.
//

import UIKit
import TrackerProViewModel
import SnapKit
import StoreKit

class SettingsViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let backButton = UIButton(type: .system)
    private let header = UILabel(text: "Settings",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))

    private let share = SettingsView(type: .other,
                                     title: "Share the app",
                                     image: "share")
    private let rate = SettingsView(type: .other,
                                     title: "Rate the app",
                                    image: "rate")
    private let usage = SettingsView(type: .usage,
                                     title: "Usage Policy",
                                     image: "usage")
    private var stack: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#001724")

        self.stack = UIStackView(arrangedSubviews: [share, rate],
                                 axis: .horizontal,
                                 spacing: 8)

        self.backButton.setImage(UIImage(named: "back"), for: .normal)
        self.header.textAlignment = .left

        self.view.addSubview(backButton)
        self.view.addSubview(header)
        self.view.addSubview(stack)
        self.view.addSubview(usage)
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

        stack.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(150)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(94)
        }

        usage.snp.makeConstraints { view in
            view.top.equalTo(stack.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(64)
        }
    }
}


extension SettingsViewController: IViewModelableController {
    typealias ViewModel = ISettingsViewModel
}

//MARK: Progress View
extension SettingsViewController {
    private func makeButtonActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        share.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        rate.addTarget(self, action: #selector(rateTapped), for: .touchUpInside)
        usage.addTarget(self, action: #selector(usageTapped), for: .touchUpInside)
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }
        TabBarRouter.popViewController(in: navigationController)
    }

    @objc func shareTapped() {
        let appStoreURL = URL(string: "https://apps.apple.com/us/app/1-sports-tracker-pro/id6737613539")!

        let activityViewController = UIActivityViewController(activityItems: [appStoreURL], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view

        activityViewController.excludedActivityTypes = [
            .postToWeibo,
            .print,
            .assignToContact,
            .saveToCameraRoll,
            .addToReadingList,
            .postToFlickr,
            .postToVimeo,
            .postToTencentWeibo,
            .openInIBooks,
            .markupAsPDF
        ]

        present(activityViewController, animated: true, completion: nil)
    }

    @objc func rateTapped() {
        guard let scene = view.window?.windowScene else { return }
        if #available(iOS 14.0, *) {
            SKStoreReviewController.requestReview()
        } else {
            let alertController = UIAlertController(
                title: "Enjoying the app?",
                message: "Please consider leaving us a review in the App Store!",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Go to App Store", style: .default) { _ in
                if let appStoreURL = URL(string: "https://apps.apple.com/us/app/1-sports-tracker-pro/id6737613539") {
                    UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
                }
            })
            present(alertController, animated: true, completion: nil)
        }
    }

    @objc func usageTapped() {
        guard let navigationController = self.navigationController else { return }
        SettingsRouter.showUsageViewController(in: navigationController)
    }
}

//MARK: Preview
import SwiftUI

struct SettingsViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let settingsViewController = SettingsViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) -> SettingsViewController {
            return settingsViewController
        }

        func updateUIViewController(_ uiViewController: SettingsViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) {
        }
    }
}
