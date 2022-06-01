//
//  EmployeeCard.swift
//  EmployeeRoster
//
//  Created by Sofia on 2022-05-28.
//

import Foundation
import UIKit

class EmployeeTableViewCell: UITableViewCell {
    static let identifier = "EmployeeTableViewCell"
    
    private let imageContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .purple
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var teamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
                
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageContainer)
        imageContainer.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(teamLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        profileImageView.frame = CGRect(x:10, y:6, width: size, height: size)
        profileImageView.center = imageContainer.center
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        teamLabel.text = nil
        imageContainer.backgroundColor = nil
    }
    
    func configure(_ employee: EmployeeViewModel) {

        nameLabel.text = employee.fullName
        teamLabel.text = employee.team
//
//        contentView.addSubview(profileImageView)
//        contentView.addSubview(nameLabel)
//        contentView.addSubview(teamLabel)
        
        // add constraints to the titleLabel
        nameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

        // add constraints to the subTitleLabel
        teamLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor).isActive = true
        teamLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        teamLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
    }
}
