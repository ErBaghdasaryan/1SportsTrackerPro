//
//  CreateMatchView.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import UIKit
import SnapKit
import TrackerProViewModel
import TrackerProModel
import Combine

final class CreateMatchView: UIView, IReusableView {
    public let date = HeaderTextField(placeholder: "DD MM YYYY",
                                       sfPro: "Regular",
                                       size: 17,
                                      isCentered: true)

    private let yourTeam = UILabel(text: "Your team",
                                   textColor: UIColor.white,
                                   font: UIFont(name: "SFProText-Regular", size: 12))
    public let firstName = UILabel(text: "",
                                    textColor: UIColor.white,
                                    font: UIFont(name: "SFProText-Regular", size: 17))
    public let firstImage = UIImageView()

    private let opponent = UILabel(text: "Opponent",
                                   textColor: UIColor.white,
                                   font: UIFont(name: "SFProText-Regular", size: 12))
    public let secondName = UILabel(text: "Team name",
                                    textColor: UIColor.white,
                                    font: UIFont(name: "SFProText-Regular", size: 17))
    public let secondImage = AddPhotoView()
    public let addImage = UIButton(type: .system)

    public let firstScore = HeaderTextField(placeholder: "-",
                                        sfPro: "Regular",
                                        size: 28)
    private let betweenScores = UILabel(text: ":",
                                        textColor: UIColor.white,
                                        font: UIFont(name: "SFProText-Regular", size: 28))
    public let secondScore = HeaderTextField(placeholder: "-",
                                        sfPro: "Regular",
                                        size: 28)
    public let city = HeaderTextField(placeholder: "City",
                                       sfPro: "Regular",
                                       size: 17,
                                      isCentered: true)
    private let victory = UILabel(text: "",
                                  textColor: UIColor.white,
                                  font: UIFont(name: "SFProText-Regular", size: 12))

    private func setupUI(isWin: Bool) {

        self.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        self.layer.cornerRadius = 10

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

        date.backgroundColor = UIColor.clear
        firstScore.backgroundColor = UIColor.clear
        secondScore.backgroundColor = UIColor.clear
        city.backgroundColor = UIColor.clear
        secondName.backgroundColor = UIColor.clear

        self.addSubview(date)
        self.addSubview(yourTeam)
        self.addSubview(firstImage)
        self.addSubview(firstName)
        self.addSubview(opponent)
        self.addSubview(secondImage)
        self.addSubview(addImage)
        self.addSubview(secondName)
        self.addSubview(betweenScores)
        self.addSubview(firstScore)
        self.addSubview(secondScore)
        self.addSubview(city)
        self.addSubview(victory)
        setupConstraints()
    }

    private func setupConstraints() {

        date.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(18)
            view.centerX.equalToSuperview()
            view.width.equalTo(116)
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
            view.leading.equalToSuperview().offset(16)
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

        addImage.snp.makeConstraints { view in
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

        betweenScores.snp.makeConstraints { view in
            view.top.equalTo(date.snp.bottom).offset(4)
            view.centerX.equalToSuperview()
            view.width.equalTo(7)
            view.height.equalTo(34)
        }

        firstScore.snp.makeConstraints { view in
            view.top.equalTo(date.snp.bottom).offset(4)
            view.trailing.equalTo(betweenScores.snp.leading).inset(-8)
            view.width.equalTo(15)
            view.height.equalTo(34)
        }

        secondScore.snp.makeConstraints { view in
            view.top.equalTo(date.snp.bottom).offset(4)
            view.leading.equalTo(betweenScores.snp.trailing).offset(8)
            view.width.equalTo(15)
            view.height.equalTo(34)
        }

        city.snp.makeConstraints { view in
            view.top.equalTo(betweenScores.snp.bottom).offset(4)
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

    public func setup(firstImage: UIImage, firstName: String, isWin: Bool) {
        self.setupUI(isWin: isWin)
        self.firstImage.image = firstImage
        self.firstName.text = firstName
    }
}
