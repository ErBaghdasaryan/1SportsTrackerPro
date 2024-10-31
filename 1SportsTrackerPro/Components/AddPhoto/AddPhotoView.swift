//
//  AddPhotoView.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import UIKit
import TrackerProModel

final class AddPhotoView: UIView {
    public let defaultImage = UIImageView(image: UIImage(named: "addImage"))
    public var image = UIImageView()

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

        self.image.backgroundColor = .clear
        self.image.contentMode = .scaleToFill

        addSubview(defaultImage)
        addSubview(image)
        setupConstraints()
    }

    private func setupConstraints() {
        defaultImage.snp.makeConstraints { view in
            view.centerY.equalToSuperview()
            view.centerX.equalToSuperview()
            view.width.equalTo(32)
            view.height.equalTo(32)
        }

        image.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }
    }

    public func setup(with image: UIImage) {
        self.image = UIImageView(image: image)
        self.setupUI()
    }
}
