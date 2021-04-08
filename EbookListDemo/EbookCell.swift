//
//  EbookCell.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 08/04/21.
//

import UIKit

class EbookCell: UITableViewCell {
    
    let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let eBookTitleNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let authorNamesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .light)
        label.textColor = .darkGray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let narratorNamesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .light)
        label.textColor = .darkGray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    private func setupView() {
        self.contentView.addSubview(coverImageView)
        self.contentView.addSubview(eBookTitleNameLabel)
        self.contentView.addSubview(authorNamesLabel)
        self.contentView.addSubview(narratorNamesLabel)
        
        setCoverImageViewConstraints()
        setEbookTitleNameLabelConstraints()
        setAuthorNamesLabelConstraints()
        setNarratorNamesLabelConstraints()
    }
    
    private func setCoverImageViewConstraints() {
        let imageView = coverImageView
        
        NSLayoutConstraint.activate([eBookTitleNameLabel.topAnchor.constraint(equalTo: imageView.topAnchor,
                                                                              constant: 4),
                                     imageView.bottomAnchor.constraint(equalTo: narratorNamesLabel.bottomAnchor,
                                                                       constant: 4),
                                     imageView.widthAnchor.constraint(equalToConstant: 84),
                                     imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                                                        constant: 8)])
    }
    
    private func setEbookTitleNameLabelConstraints() {
        let label = eBookTitleNameLabel
        
        NSLayoutConstraint.activate([label.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor,
                                                                    constant: 12),
                                     self.contentView.trailingAnchor.constraint(equalTo: label.trailingAnchor,
                                                                                constant: 4),
                                     label.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                                                constant: 12)])
    }
    
    private func setAuthorNamesLabelConstraints() {
        let label = authorNamesLabel
        
        NSLayoutConstraint.activate([label.leadingAnchor.constraint(equalTo: eBookTitleNameLabel.leadingAnchor),
                                     label.trailingAnchor.constraint(equalTo: eBookTitleNameLabel.trailingAnchor),
                                     label.topAnchor.constraint(equalTo: eBookTitleNameLabel.bottomAnchor,
                                                                constant: 12)])
    }
    
    private func setNarratorNamesLabelConstraints() {
        let label = narratorNamesLabel
        
        NSLayoutConstraint.activate([label.leadingAnchor.constraint(equalTo: eBookTitleNameLabel.leadingAnchor),
                                     label.trailingAnchor.constraint(equalTo: eBookTitleNameLabel.trailingAnchor),
                                     label.topAnchor.constraint(equalTo: authorNamesLabel.bottomAnchor,
                                                                constant: 4),
                                     self.contentView.bottomAnchor.constraint(equalTo: label.bottomAnchor,
                                                                              constant: 12)])
    }
    
}

extension EbookCell {
    
    func setup(with viewModel: EbookCellVM) {
        eBookTitleNameLabel.text = viewModel.eBookTitleName
        authorNamesLabel.text = viewModel.authorNamesText
        narratorNamesLabel.text = viewModel.narratorNamesText
    }
    
}
