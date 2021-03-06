//
//  ListCell.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit
import SnapKit

final class ListCell: UITableViewCell {
    lazy var nameTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = StringKey.Generic.Name.get()
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    lazy var licensePlateTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = StringKey.Generic.LicensePlate.get()
        return label
    }()
    
    lazy var licensePlateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    lazy var carImageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        selectionStyle = .none
        contentView.addSubview(nameTitleLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(licensePlateTitleLabel)
        contentView.addSubview(licensePlateLabel)
        contentView.addSubview(carImageView)
        
        nameTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(10)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameTitleLabel.snp.trailing).offset(5)
            make.top.equalToSuperview().inset(10)
        }
        
        licensePlateTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        licensePlateLabel.snp.makeConstraints { make in
            make.leading.equalTo(licensePlateTitleLabel.snp.trailing).offset(5)
            make.top.equalTo(licensePlateTitleLabel)
            make.bottom.equalToSuperview().inset(10)
        }
        
        carImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(nameLabel)
            make.width.equalTo(88)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel: CarRowViewModel) {
        nameLabel.text = viewModel.name
        licensePlateLabel.text = viewModel.licensePlate
        let placeHodlerImage = MobileAsset.CarPlaceHolder.getImage()
        carImageView.loadImage(withUrlString: viewModel.carImageUrl, placeholderImage: placeHodlerImage)
    }
}
