//
//  TeamView.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import UIKit
import TrackerProModel

final class TeamView: UIButton {
    private let title = UILabel(text: "",
                                textColor: .black,
                                font: UIFont(name: "SFProText-Semibold", size: 17))
    private var image = UIImageView()

    public init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        self.backgroundColor = UIColor.white

        self.layer.cornerRadius = 18

        self.title.textAlignment = .left

        self.addSubview(image)
        self.addSubview(title)
        setupConstraints()
    }

    private func setupConstraints() {

        image.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(8)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(32)
            view.height.equalTo(32)
        }

        title.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(13)
            view.leading.equalTo(image.snp.trailing).offset(8)
            view.trailing.equalToSuperview().inset(10)
            view.height.equalTo(22)
        }
    }

    public func setup(with image: UIImage, name: String) {
        self.image.image = image
        self.title.text = name
        self.setupUI()
    }
}

