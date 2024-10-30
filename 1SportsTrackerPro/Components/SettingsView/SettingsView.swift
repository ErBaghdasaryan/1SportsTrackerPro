//
//  SettingsView.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 29.10.24.
//

import UIKit
import TrackerProModel

final class SettingsView: UIButton {
    private let title = UILabel(text: "",
                                textColor: .white,
                                font: UIFont(name: "SFProText-Semibold", size: 17))
    private var image = UIImageView()
    private var type: SettingsType

    public init(type: SettingsType, title: String, image: String) {
        self.type = type
        self.title.text = title
        self.image.image = UIImage(named: image)
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        self.backgroundColor = UIColor.white.withAlphaComponent(0.05)

        self.layer.cornerRadius = 10

        switch self.type {
        case .usage:
            self.title.textAlignment = .left

            addSubview(image)
            addSubview(title)
        case .other:
            self.title.textAlignment = .center

            addSubview(title)
            addSubview(image)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        switch self.type {
        case .usage:
            image.snp.makeConstraints { view in
                view.top.equalToSuperview().offset(16)
                view.leading.equalToSuperview().offset(110.5)
                view.width.equalTo(32)
                view.height.equalTo(32)
            }

            title.snp.makeConstraints { view in
                view.top.equalToSuperview().offset(21.5)
                view.leading.equalTo(image.snp.trailing).offset(8)
                view.width.equalTo(120)
                view.height.equalTo(21)
            }
        case .other:
            title.snp.makeConstraints { view in
                view.top.equalToSuperview().offset(16)
                view.leading.equalToSuperview().offset(16)
                view.trailing.equalToSuperview().inset(16)
                view.height.equalTo(22)
            }

            image.snp.makeConstraints { view in
                view.top.equalTo(title.snp.bottom).offset(8)
                view.centerX.equalToSuperview()
                view.width.equalTo(32)
                view.height.equalTo(32)
            }
        }
    }
}

enum SettingsType {
    case usage
    case other
}
