//
//  NewClassroomViewController.swift
//  Ignite Teams
//
//  Created by Yuri Correa on 21/06/24.
//

import UIKit

class NewClassroomViewController: UIViewController {

    weak var delegate: DataPassingDelegate?
    
    private lazy var headerStack : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            backButton,
            headerLogo
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
    
        return stackView
    }()
    
    private lazy var contentView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        personIcon,
        classroomTitle,
        classroomDescription,
        inputClassroom,
        createNewClassroomButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12
      
        return stackView
    }()
    
    private lazy var headerLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.logo
        imageView.contentMode = .scaleAspectFit
 
        return imageView
    }()
    
    private lazy var personIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.person
    
        return imageView
    }()
    
     private func goToBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createNewClassroom), for: .touchDown)
       
        let image = UIImage(named: "Back")
        
        button.setImage(image, for: .normal)
        return button
    }()
    
    private lazy var classroomTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.text = "Nova Turma"
        return label
    }()
    
    private lazy var classroomDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white.withAlphaComponent(0.4)
        label.text = "crie uma turma para adicionar pessoas"
        return label
    }()
    
    @objc func createNewClassroom() {
        if inputClassroom.text != "" {
            delegate?.addNewClassroom(title: inputClassroom.text ?? "")
        }
        navigationController?.popViewController(animated: true)
    }
    
    private lazy var createNewClassroomButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Criar", for: .normal)
        button.addTarget(self, action: #selector(createNewClassroom), for: .touchDown)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .green700
        button.layer.cornerRadius = 6
        return button
    }()
    
    private lazy var inputClassroom : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.borderStyle = .roundedRect
        textField.textColor = .gray300
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.attributedPlaceholder = NSAttributedString(string: "Nome da turma", attributes: [
            .foregroundColor: UIColor.gray300,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
        ])
        
        textField.backgroundColor = .gray700
        return textField
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        // Do any additional setup after loading the view.
            
        setupNavigation()
        addSubviews()
        setupConstraints()

    }
    
    
    public func setupNavigation() {
        navigationController?.navigationBar.isHidden = true
    }

    private func addSubviews() {
        view.addSubview(headerStack)
        view.addSubview(contentView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
          
            
            contentView.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 100),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      
            
            createNewClassroomButton.topAnchor.constraint(equalTo: inputClassroom.bottomAnchor, constant: 16),
            createNewClassroomButton.heightAnchor.constraint(equalToConstant: 55),
            createNewClassroomButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            createNewClassroomButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            inputClassroom.heightAnchor.constraint(equalToConstant: 56),
            inputClassroom.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            inputClassroom.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
