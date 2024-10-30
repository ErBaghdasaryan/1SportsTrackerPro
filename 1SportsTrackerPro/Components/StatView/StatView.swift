//
//  StatView.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 29.10.24.
//

import UIKit
import TrackerProModel

final class StatView: UIView {
    private let title = UILabel(text: "",
                                textColor: .white,
                                font: UIFont(name: "SFProText-Regular", size: 17))
    private let count = UILabel(text: "0",
                                textColor: .white,
                                font: UIFont(name: "SFProText-Regular", size: 28))
    private var image = UIImageView()
    private var isWinsPersintage: Bool = false

    public init(title: String, image: String, isWinsPersintage: Bool = false) {
        self.title.text = title
        self.image.image = UIImage(named: image)
        self.isWinsPersintage = isWinsPersintage
        if isWinsPersintage {
            self.count.text = "0,0%"
        }
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        self.backgroundColor = UIColor.white.withAlphaComponent(0.05)

        self.layer.cornerRadius = 10

        self.title.textAlignment = .left
        self.count.textAlignment = .left

        if isWinsPersintage {
            count.textColor = UIColor(hex: "#40D665")
        }

        addSubview(title)
        addSubview(count)
        addSubview(image)
        setupConstraints()
    }

    private func setupConstraints() {
        title.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(56)
            view.height.equalTo(22)
        }

        count.snp.makeConstraints { view in
            view.top.equalTo(title.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(56)
            view.height.equalTo(34)
        }

        image.snp.makeConstraints { view in
            view.centerY.equalToSuperview()
            view.trailing.equalToSuperview().inset(16)
            view.width.equalTo(32)
            view.height.equalTo(32)
        }
    }

    public func setup(with count: String) {
        if isWinsPersintage {
            self.count.text = "\(count)%"
        } else {
            self.count.text = count
        }
        self.setupUI()
    }
}

