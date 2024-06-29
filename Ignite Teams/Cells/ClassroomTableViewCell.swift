//
//  ClassroomTableViewCell.swift
//  Ignite Teams
//
//  Created by Yuri Correa on 22/06/24.
//

import UIKit

class ClassroomTableViewCell: UITableViewCell {


    private lazy var cardView: UIView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray500
        view.layer.cornerRadius = 6
        view.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return view
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Teste"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private lazy var personSolid: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.personSolid
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
    
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func addSubviews() {
        addSubview(cardView)
        cardView.addSubview(personSolid)
        cardView.addSubview(title)
        backgroundColor = .clear
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 96),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            personSolid.centerYAnchor.constraint(equalTo: centerYAnchor),
            personSolid.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: personSolid.trailingAnchor, constant: 16)
        ])
    }
    
    func configureCell(classroom: Classroom) {
        title.text = classroom.title
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


#Preview {
    ClassroomTableViewCell()
}
