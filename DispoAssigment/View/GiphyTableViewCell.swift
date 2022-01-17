//
//  GiphyTableViewCell.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/16/22.
//

import UIKit
import SnapKit

class GiphyTableViewCell: UITableViewCell {
    static let reuseIdentifier = "GiphyTableViewCell"
    
    private var gifImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    private func setupUI(){
        addSubview(gifImage)
        addSubview(titleLabel)
       
        gifImage.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.leading.top.equalTo(10)
            make.bottom.equalTo(-10)
        }
           
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.gifImage.snp.trailing).offset(10)
            make.trailing.equalTo(10)
            make.top.equalTo(15)
            make.bottom.equalTo(-15)
        }
    }
    
    func configure(viewModel: GiphyViewModelCell) {
        titleLabel.text = viewModel.title
        gifImage.load(url: viewModel.url)
    }
    
}
