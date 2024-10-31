//
//  EventPlayerStatView.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import UIKit
import TrackerProModel

final class EventPlayerStatView: UIView {
    private let title = UILabel(text: "",
                                textColor: .white,
                                font: UIFont(name: "SFProText-Semibold", size: 17))
    public var count: HeaderTextField!

    public init(title: String, placeholder: String) {
        self.title.text = title
        self.count = HeaderTextField(placeholder: placeholder,
                                     sfPro: "Regular",
                                     size: 28,
                                     isCentered: true)
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        self.backgroundColor = UIColor.white.withAlphaComponent(0.05)

        self.layer.cornerRadius = 10

        self.title.textAlignment = .center
        self.count.textAlignment = .center
        self.count.backgroundColor = .clear

        addSubview(title)
        addSubview(count)
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
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }
    }
}
