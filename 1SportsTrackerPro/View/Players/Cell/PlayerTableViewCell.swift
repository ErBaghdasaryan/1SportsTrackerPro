//
//  PlayerTableViewCell.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import UIKit
import SnapKit
import TrackerProViewModel
import TrackerProModel
import Combine

final class PlayerTableViewCell: UITableViewCell, IReusableView {

    private let content = UIView()

    private let number = UILabel(text: "",
                                 textColor: UIColor.white,
                                 font: UIFont(name: "SFProText-Semibold", size: 17))
    private let name = UILabel(text: "",
                               textColor: UIColor.white,
                               font: UIFont(name: "SFProText-Semibold", size: 17))
    private let image = UIImageView()
    private let howLong = UILabel(text: "How long in team",
                                  textColor: UIColor.white,
                                  font: UIFont(name: "SFProText-Regular", size: 12))
    private let howCount = UILabel(text: "",
                                   textColor: UIColor.white,
                                   font: UIFont(name: "SFProText-Regular", size: 22))
    private let goals = UILabel(text: "G",
                                   textColor: UIColor.white,
                                   font: UIFont(name: "SFProText-Regular", size: 12))
    private let assists = UILabel(text: "A",
                                   textColor: UIColor.white,
                                   font: UIFont(name: "SFProText-Regular", size: 12))
    private let penalties = UILabel(text: "P",
                                   textColor: UIColor.white,
                                   font: UIFont(name: "SFProText-Regular", size: 12))
    private let goalsCount = UILabel(text: "G",
                                   textColor: UIColor(hex: "#40D665")!,
                                   font: UIFont(name: "SFProText-Regular", size: 17))
    private let assistsCount = UILabel(text: "A",
                                   textColor: UIColor(hex: "#00A2FF")!,
                                   font: UIFont(name: "SFProText-Regular", size: 17))
    private let penaltiesCount = UILabel(text: "P",
                                   textColor: UIColor(hex: "#FC424B")!,
                                   font: UIFont(name: "SFProText-Regular", size: 17))
    private let firstLine = UIView()
    private let secondLine = UIView()
    private var horizontalFirs: UIStackView!
    private var horizontalSecond: UIStackView!
    private var vertical: UIStackView!

    private func setupUI() {

        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.content.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        self.content.layer.cornerRadius = 10

        self.name.textAlignment = .left
        self.howLong.textAlignment = .right
        self.howCount.textAlignment = .right

        self.firstLine.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        self.secondLine.backgroundColor = UIColor.white.withAlphaComponent(0.2)

        self.image.layer.masksToBounds = true
        self.image.layer.cornerRadius = 15

        self.number.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        self.number.layer.masksToBounds = true
        self.number.layer.cornerRadius = 4

        self.horizontalFirs = UIStackView(arrangedSubviews: [goals, assists, penalties],
                                          axis: .horizontal,
                                          spacing: 12)
        self.horizontalSecond = UIStackView(arrangedSubviews: [goalsCount, assistsCount, penaltiesCount],
                                          axis: .horizontal,
                                          spacing: 12)
        self.vertical = UIStackView(arrangedSubviews: [horizontalFirs, horizontalSecond],
                                    axis: .vertical,
                                    spacing: 4)

        addSubview(content)
        self.content.addSubview(number)
        self.content.addSubview(name)
        self.content.addSubview(image)
        self.content.addSubview(vertical)
        self.content.addSubview(firstLine)
        self.content.addSubview(secondLine)
        self.content.addSubview(howLong)
        self.content.addSubview(howCount)
        setupConstraints()
    }

    private func setupConstraints() {

        content.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(8)
            view.leading.equalToSuperview().offset(3)
            view.trailing.equalToSuperview().inset(3)
            view.bottom.equalToSuperview().inset(8)
        }

        number.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(16)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(27)
            view.height.equalTo(30)
        }

        name.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(20)
            view.leading.equalTo(number.snp.trailing).offset(8)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(22)
        }

        image.snp.makeConstraints { view in
            view.top.equalTo(number.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(64)
            view.height.equalTo(64)
        }

        vertical.snp.makeConstraints { view in
            view.top.equalTo(image.snp.top).offset(11)
            view.leading.equalTo(image.snp.trailing).offset(16)
            view.width.equalTo(94)
            view.height.equalTo(42)
        }

        howLong.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(41)
            view.trailing.equalToSuperview().inset(16)
            view.width.equalTo(110)
            view.height.equalTo(16)
        }

        howCount.snp.makeConstraints { view in
            view.top.equalTo(howLong.snp.bottom).offset(6)
            view.trailing.equalToSuperview().inset(16)
            view.width.equalTo(110)
            view.height.equalTo(28)
        }
    }

    public func setup(model: PlayerModel) {
        self.image.image = model.image
        self.name.text = model.name
        self.number.text = model.playerNumber
        self.goalsCount.text = model.goals
        self.assistsCount.text = model.assistance
        self.penaltiesCount.text = model.penalties
        self.howCount.text = "\(model.howLong) month"

        self.setupUI()
    }
}
