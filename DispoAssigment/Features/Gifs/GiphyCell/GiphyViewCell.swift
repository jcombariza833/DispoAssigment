//
//  GiphyTableViewCell.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/16/22.
//

import UIKit
import SnapKit

class GiphyViewCell: UICollectionViewCell {
    static let reuseIdentifier = "GiphyTableViewCell"
    
    var gifImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        
        return label
    }()

    override init(frame: CGRect) {
      super.init(frame: frame)
      setupUI()
    }

    private func setupUI(){
        addSubview(gifImage)
        addSubview(titleLabel)

        gifImage.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.leading.top.equalTo(10)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.gifImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
        }
    }

    override func prepareForReuse() {
      super.prepareForReuse()
      prepareForConfiguration()
    }

    private func prepareForConfiguration() {
      titleLabel.text = nil
      gifImage.image = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
