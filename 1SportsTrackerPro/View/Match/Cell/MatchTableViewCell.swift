//
//  MatchTableViewCell.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import UIKit
import SnapKit
import TrackerProViewModel
import TrackerProModel
import Combine

final class MatchTableViewCell: UITableViewCell, IReusableView {

    private let content = UIView()

    private let date = UILabel(text: "",
                               textColor: UIColor.white,
                               font: UIFont(name: "SFProText-Regular", size: 17))

    private let yourTeam = UILabel(text: "Your team",
                                   textColor: UIColor.white,
                                   font: UIFont(name: "SFProText-Regular", size: 12))
    private let firstName = UILabel(text: "",
                                    textColor: UIColor.white,
                                    font: UIFont(name: "SFProText-Regular", size: 17))
    private let firstImage = UIImageView()

    private let opponent = UILabel(text: "Opponent",
                                   textColor: UIColor.white,
                                   font: UIFont(name: "SFProText-Regular", size: 12))
    private let secondName = UILabel(text: "",
                                     textColor: UIColor.white,
                                     font: UIFont(name: "SFProText-Regular", size: 17))
    private let secondImage = UIImageView()

    private let score = UILabel(text: "",
                                textColor: UIColor.white,
                                font: UIFont(name: "SFProText-Regular", size: 28))
    private let city = UILabel(text: "",
                               textColor: UIColor.white,
                               font: UIFont(name: "SFProText-Regular", size: 17))
    private let victory = UILabel(text: "",
                                  textColor: UIColor.white,
                                  font: UIFont(name: "SFProText-Regular", size: 12))

    private func setupUI(isWin: Bool) {

        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.content.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.content.layer.cornerRadius = 10

        if isWin {
            self.victory.backgroundColor = UIColor(hex: "#40D665")
            self.victory.layer.cornerRadius = 7
            self.victory.layer.masksToBounds = true
            self.victory.text = "Victory"
        } else {
            self.victory.backgroundColor = UIColor(hex: "#FC424B")
            self.victory.layer.cornerRadius = 7
            self.victory.layer.masksToBounds = true
            self.victory.text = "Defeat"
        }

        addSubview(content)
        self.content.addSubview(date)
        self.content.addSubview(yourTeam)
        self.content.addSubview(firstImage)
        self.content.addSubview(firstName)
        self.content.addSubview(opponent)
        self.content.addSubview(secondImage)
        self.content.addSubview(secondName)
        self.content.addSubview(score)
        self.content.addSubview(city)
        self.content.addSubview(victory)
        setupConstraints()
    }

    private func setupConstraints() {

        content.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(8)
            view.leading.equalToSuperview().offset(3)
            view.trailing.equalToSuperview().inset(3)
            view.bottom.equalToSuperview().inset(8)
        }

        date.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(18)
            view.leading.equalToSuperview().offset(116)
            view.trailing.equalToSuperview().inset(116)
            view.height.equalTo(22)
        }

        yourTeam.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(16)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(100)
            view.height.equalTo(16)
        }

        firstImage.snp.makeConstraints { view in
            view.top.equalTo(yourTeam.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(34)
            view.width.equalTo(64)
            view.height.equalTo(64)
        }

        firstName.snp.makeConstraints { view in
            view.top.equalTo(firstImage.snp.bottom).offset(8)
            view.trailing.equalToSuperview().inset(16)
            view.width.equalTo(100)
            view.height.equalTo(22)
        }

        opponent.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.width.equalTo(100)
            view.height.equalTo(16)
        }

        secondImage.snp.makeConstraints { view in
            view.top.equalTo(opponent.snp.bottom).offset(8)
            view.trailing.equalToSuperview().inset(34)
            view.width.equalTo(64)
            view.height.equalTo(64)
        }

        secondName.snp.makeConstraints { view in
            view.top.equalTo(secondImage.snp.bottom).offset(8)
            view.trailing.equalToSuperview().inset(16)
            view.width.equalTo(100)
            view.height.equalTo(22)
        }

        score.snp.makeConstraints { view in
            view.top.equalTo(date.snp.bottom).offset(4)
            view.centerX.equalToSuperview()
            view.width.equalTo(126)
            view.height.equalTo(34)
        }

        city.snp.makeConstraints { view in
            view.top.equalTo(score.snp.bottom).offset(4)
            view.centerX.equalToSuperview()
            view.width.equalTo(126)
            view.height.equalTo(22)
        }

        victory.snp.makeConstraints { view in
            view.top.equalTo(city.snp.bottom).offset(4)
            view.centerX.equalToSuperview()
            view.width.equalTo(55)
            view.height.equalTo(24)
        }
    }

    public func setup(model: MatchModel) {
        self.firstImage.image = model.firstImage
        self.firstName.text = model.firstName
        self.date.text = model.date
        self.score.text = "\(model.firstScore) : \(model.secondScore)"
        self.city.text = model.city

        self.setupUI(isWin: model.isVictory)
    }
}