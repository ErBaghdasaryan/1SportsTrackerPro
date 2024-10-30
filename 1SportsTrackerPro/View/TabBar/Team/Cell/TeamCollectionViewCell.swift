//
//  TeamCollectionViewCell.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import UIKit
import TrackerProModel

final class TeamCollectionViewCell: UICollectionViewCell, IReusableView  {

    private let image = UIImageView()
    private let header = UILabel(text: "",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Semibold", size: 17))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.05)

        self.header.textAlignment = .center
        self.layer.cornerRadius = 15

        self.addSubview(header)
        self.addSubview(image)
        setupConstraints()
    }

    private func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(22)
        }

        image.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(8)
            view.centerX.equalToSuperview()
            view.width.equalTo(64)
            view.height.equalTo(64)
        }
    }

    public func setSelectedState(_ isSelected: Bool) {
        self.layer.borderColor = isSelected ? UIColor(hex: "#00A2FF")!.cgColor : UIColor.clear.cgColor
        self.layer.borderWidth = isSelected ? 1 : 0
    }

    public func setup(with header: String, and image: UIImage) {
        self.header.text = header
        self.image.image = image
        self.setupUI()
    }
}

