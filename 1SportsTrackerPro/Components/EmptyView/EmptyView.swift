//
//  EmptyView.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import UIKit
import TrackerProModel

final class EmptyView: UIView, IReusableView  {

    private let image = UIImageView()
    private let header = UILabel(text: "",
                                 textColor: .white.withAlphaComponent(0.2),
                                 font: UIFont(name: "SFProText-Regular", size: 17))

    private func setupUI() {
        self.backgroundColor = UIColor(hex: "#001724")

        self.header.textAlignment = .center
        self.header.numberOfLines = 2

        self.addSubview(image)
        self.addSubview(header)
        setupConstraints()
    }

    private func setupConstraints() {
        image.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.centerX.equalToSuperview()
            view.width.equalTo(32)
            view.height.equalTo(32)
        }

        header.snp.makeConstraints { view in
            view.top.equalTo(image.snp.bottom).offset(8)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(44)
        }
    }

    public func setup(with header: String, and image: UIImage) {
        self.header.text = header
        self.image.image = image
        self.setupUI()
    }
}
