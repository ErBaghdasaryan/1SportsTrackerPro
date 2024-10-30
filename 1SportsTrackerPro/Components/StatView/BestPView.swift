//
//  BestPView.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 29.10.24.
//

import UIKit
import TrackerProModel

final class BestPView: UIView {
    private let title = UILabel(text: "Best player",
                                textColor: .white,
                                font: UIFont(name: "SFProText-Regular", size: 17))
    private let count = UILabel(text: "0",
                                textColor: .white,
                                font: UIFont(name: "SFProText-Regular", size: 28))
    private var name = UILabel(text: "Name",
                               textColor: .white,
                               font: UIFont(name: "SFProText-Regular", size: 22))

    public init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        self.backgroundColor = UIColor.white.withAlphaComponent(0.05)

        self.layer.cornerRadius = 10

        self.name.textAlignment = .left

        self.count.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        self.count.layer.masksToBounds = true
        self.count.layer.cornerRadius = 5

        addSubview(title)
        addSubview(count)
        addSubview(name)
        setupConstraints()
    }

    private func setupConstraints() {
        title.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(22)
        }

        count.snp.makeConstraints { view in
            view.top.equalTo(title.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(132)
            view.trailing.equalToSuperview().inset(195)
            view.height.equalTo(36)
        }

        name.snp.makeConstraints { view in
            view.top.equalTo(title.snp.bottom).offset(12)
            view.leading.equalTo(count.snp.trailing).offset(8)
            view.trailing.equalToSuperview().inset(125)
            view.height.equalTo(28)
        }
    }

    public func setup(with count: String, and name: String) {
        self.count.text = count
        self.name.text = name
        self.setupUI()
    }
}
