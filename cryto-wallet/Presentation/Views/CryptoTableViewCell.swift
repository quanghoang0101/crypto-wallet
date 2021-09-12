//
//  CryptoTableViewCell.swift
//  cryto-wallet
//
//  Created by Hoang on 09/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import UIKit
import SDWebImage

class CryptoTableViewCell: UITableViewCell {

    var favorited: ((_ cell: UITableViewCell) -> Void)?

    private lazy var containerView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()

    private lazy var cornerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0xf1f3f3)
        view.cornerRadius = 5.0
        return view;
    }()

    private lazy var cryptoImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        return label
    }()

    private lazy var buyPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0x00c8bc)
        return label
    }()

    private lazy var sellPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemRed
        return label
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.star_unselected(), for: .normal)
        button.setImage(R.image.star_selected(), for: .selected)
        button.addTarget(self, action: #selector(favoritePressed(_:)), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = .none
        self.configViews()
        self.configContraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configViews() {
        self.contentView.addSubview(containerView)

        self.containerView.addSubview(cornerView)
        self.cornerView.addSubview(cryptoImageView)
        self.containerView.addSubview(titleLabel)
        self.containerView.addSubview(subtitleLabel)
        self.containerView.addSubview(buyPriceLabel)
        self.containerView.addSubview(sellPriceLabel)
        self.containerView.addSubview(favoriteButton)
    }

    private func configContraints() {
        self.containerView.snp.makeConstraints { maker in
            maker.leading.trailing.top.bottom.equalToSuperview()
            maker.height.equalTo(80).priority(750)
        }
        self.favoriteButton.snp.makeConstraints { maker in
            maker.width.height.equalTo(20)
            maker.centerY.equalToSuperview()
            maker.trailing.equalToSuperview().inset(16)
        }

        self.configCryptoViewContraints()
        self.configTitleAndSubtitleContraints()
        self.configPriceContraints()
    }

    private func configCryptoViewContraints() {

        self.cornerView.snp.makeConstraints { maker in
            maker.width.height.equalTo(50)
            maker.leading.equalToSuperview().offset(16)
            maker.centerY.equalToSuperview()
        }

        self.cryptoImageView.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
            maker.width.height.equalTo(30)
        }
    }

    private func configTitleAndSubtitleContraints() {
        self.titleLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(cornerView.snp.trailing).offset(16)
            maker.top.equalTo(cornerView)
        }

        self.subtitleLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(titleLabel.snp.leading)
            maker.bottom.equalTo(cornerView)
        }
        self.titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.subtitleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

    private func configPriceContraints() {
        self.buyPriceLabel.snp.makeConstraints { maker in
            maker.trailing.equalTo(favoriteButton.snp.leading).inset(-16)
            maker.top.equalTo(cornerView)
            maker.leading.equalTo(titleLabel.snp.trailing).offset(16)
        }
        
        self.sellPriceLabel.snp.makeConstraints { maker in
            maker.trailing.equalTo(buyPriceLabel.snp.trailing)
            maker.bottom.equalTo(cornerView)
            maker.leading.equalTo(subtitleLabel.snp.trailing).offset(16)
        }

        self.buyPriceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.sellPriceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }

    private func updateHiddenFavoriteContraints() {
        self.favoriteButton.snp.remakeConstraints { maker in
            maker.width.height.equalTo(20)
            maker.centerY.equalToSuperview()
            maker.trailing.equalToSuperview().offset(16)
        }
    }

    // MARK: - Public
    func hideFavorite() {
        self.favoriteButton.isHidden = true;
        updateHiddenFavoriteContraints()
    }

    func setData(_ entity: CurrencyEntity) {
        self.titleLabel.text = entity.name
        self.subtitleLabel.text = entity.base
        self.cryptoImageView.sd_setImage(with: URL(string: entity.icon), completed: nil)
        self.favoriteButton.isSelected = entity.isSelected

        let buy = entity.buyPrice == 0.0 ? "- -" : entity.buyPrice.description
        let sell = entity.sellPrice == 0.0 ? "- -" : entity.sellPrice.description
        self.buyPriceLabel.text = buy
        self.sellPriceLabel.text = sell
    }

    // MARK: - Action
    @objc private func favoritePressed(_ button: UIButton) {
        self.favorited?(self)
    }

}
