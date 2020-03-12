//
//  CatTableViewCell.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import UIKit
import SnapKit

class CatTableViewCell: UITableViewCell {

    let catImageView = ImageLoader()
    let catBreedLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(catImageView)
        contentView.addSubview(catBreedLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupConstraints(){
        catImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(8)
            make.leading.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView).offset(-8)
            make.width.equalTo(catImageView.snp.height).multipliedBy(1)
        }
        
        catBreedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(8)
            make.leading.equalTo(catImageView.snp.trailing).offset(8)
            make.bottom.equalTo(contentView).offset(-8)
            make.trailing.equalTo(contentView).offset(-8)
        }
    }

}
