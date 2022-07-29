//
//  CustomCell.swift
//  MVVMBeer
//
//  Created by Шермат Эшеров on 27/7/22.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

class CustomCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    private lazy var beerImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var beerTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var taglineTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()

    }
}

extension CustomCell{
    
    func setupConstraints(){
        let elements = [beerImage, beerTitle, taglineTitle, yearLabel]
        for element in elements {
            contentView.addSubview(element)
        }
        
        beerImage.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.top.equalTo(20)
            make.bottom.equalTo(-20)
            make.width.equalTo(contentView.frame.width/3)
        }
        
        beerTitle.snp.makeConstraints { make in
            make.leading.equalTo(beerImage.snp.trailing).offset(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(40)
        }
        
        taglineTitle.snp.makeConstraints { make in
            make.leading.equalTo(beerImage.snp.trailing).offset(20)
            make.top.equalTo(beerTitle.snp.bottom).offset(25)
            make.trailing.equalTo(-20)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.leading.equalTo(beerImage.snp.trailing).offset(20)
            make.bottom.equalTo(-40)
        }
    }
    
    func fetchData(title: String, image: String, tagline: String, yearLabel: String){
        self.beerTitle.text = title
        self.beerImage.kf.indicatorType = .activity
        self.beerImage.kf.setImage(with: URL(string: image), placeholder: nil, options: nil, completionHandler: nil)
        self.taglineTitle.text = tagline
        self.yearLabel.text = yearLabel
    }
}
