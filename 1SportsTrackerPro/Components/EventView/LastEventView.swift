//
//  LastEventView.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import UIKit
import SnapKit
import TrackerProViewModel
import TrackerProModel
import Combine

final class LastEventView: UIView, IReusableView {

    private let name = UILabel(text: "",
                               textColor: UIColor.white,
                               font: UIFont(name: "SFProText-Semibold", size: 17))
    
    private let date = UILabel(text: "Your team",
                               textColor: UIColor.white,
                               font: UIFont(name: "SFProText-Regular", size: 17))
    private let startAt = UILabel(text: "",
                                  textColor: UIColor.white,
                                  font: UIFont(name: "SFProText-Regular", size: 28))
    private let image = UIImageView()

    private func setupUI() {

        self.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        self.layer.cornerRadius = 10

        self.name.textAlignment = .left
        self.date.textAlignment = .left
        self.startAt.textAlignment = .left

        self.addSubview(name)
        self.addSubview(date)
        self.addSubview(startAt)
        self.addSubview(image)
        setupConstraints()
    }

    private func setupConstraints() {

        name.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(22)
        }

        date.snp.makeConstraints { view in
            view.top.equalTo(name.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(22)
        }

        startAt.snp.makeConstraints { view in
            view.top.equalTo(date.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }

        image.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(31)
            view.trailing.equalToSuperview().inset(16)
            view.width.equalTo(64)
            view.height.equalTo(64)
        }
    }

    public func setup(model: EventModel) {
        self.image.image = model.image
        self.name.text = model.name
        self.startAt.text = model.startTime
        self.date.text = model.date

        self.setupUI()
    }
}
