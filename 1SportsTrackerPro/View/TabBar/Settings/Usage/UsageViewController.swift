//
//  UsageViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import UIKit
import WebKit
import SnapKit

final class UsageViewController: BaseViewController {

    private let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        self.webView.backgroundColor = .clear
        if let url = URL(string: "https://www.termsfeed.com/live/d0f0f315-5d23-4e00-b2f6-b9bbeaa43802") {
            webView.load(URLRequest(url: url))
        }

        setupConstraints()
    }

    private func setupConstraints() {
        self.view.addSubview(webView)

        webView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
        }
    }

    override func setupViewModel() {

    }

}

import SwiftUI

struct UsageViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let usageViewController = UsageViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<UsageViewControllerProvider.ContainerView>) -> UsageViewController {
            return usageViewController
        }

        func updateUIViewController(_ uiViewController: UsageViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<UsageViewControllerProvider.ContainerView>) {
        }
    }
}
