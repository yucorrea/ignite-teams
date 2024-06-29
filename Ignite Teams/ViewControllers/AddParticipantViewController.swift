//
//  NewClassroomViewController.swift
//  Ignite Teams
//
//  Created by Yuri Correa on 21/06/24.
//

import UIKit

class AddParticipantViewController: UIViewController {
    var classroom: Classroom
    var selectedTeam = Team.A

    
    weak var delegate: DataPassingDelegate?
    
    init(classroom: Classroom) {
        self.classroom = classroom
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var teamA : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Time A", for: .normal)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.titleLabel?.textColor = .white
        button.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        button.addTarget(self, action: #selector(changeSelectedTeamA), for: .touchDown)
        return button
        
    }()
    
    private lazy var teamB : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Time B", for: .normal)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.titleLabel?.textColor = .gray200
        button.addTarget(self, action: #selector(changeSelectedTeamB), for: .touchDown)
        return button
        
    }()
    
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
        classroomTitle,
        classroomDescription,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12
      
        return stackView
    }()
    
    private lazy var inputContentView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        inputClassroom,
        addButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
     
        stackView.backgroundColor = .gray700
        stackView.layer.cornerRadius = 6
        return stackView
    }()
    
    
    private lazy var headerLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.logo
        imageView.contentMode = .scaleAspectFit
 
        return imageView
    }()
        
    @objc
     private func goToBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToBack), for: .touchDown)
        let image = UIImage(named: "Back")
        button.setImage(image, for: .normal)
        return button
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createNewClassroom), for: .touchDown)
  
        let image = UIImage(named: "Add")
        button.setImage(image, for: .normal)
        
        return button
    }()
    
    private lazy var classroomTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var classroomDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white.withAlphaComponent(0.4)
        label.text = "adicione a galera e separe os times"
        return label
    }()
    
    private lazy var totalParticipants: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray200
       
        return label
    }()
    
    func loadTotalParticipants() {
        totalParticipants.text = "\(classroom.participants.filter({$0.team == selectedTeam}).count)"
    }
    
    
    @objc func createNewClassroom() {
        if ((inputClassroom.text?.isEmpty) != nil) {
            let id = classroom.participants.count + 1
            
            classroom.participants.append(Participant(id: id, name: inputClassroom.text ?? "", team: selectedTeam))
            delegate?.addParticipantInClassroom(classroomId: classroom.id, participants: classroom.participants)
            
            inputClassroom.text = ""
            loadTotalParticipants()
            participantsTableView.reloadData()
        }
        
    }
    
    @objc func changeSelectedTeamA() {
        selectedTeam = Team.A
        
        teamB.layer.borderWidth = 0
        teamB.titleLabel?.textColor = .gray200
        
        teamA.layer.borderColor = UIColor.green700.cgColor
        teamA.layer.borderWidth = 1
        teamA.titleLabel?.textColor = .white
        
      
        participantsTableView.reloadData()
        loadTotalParticipants()
    }
    
    @objc func changeSelectedTeamB() {
        selectedTeam = Team.B
        
        teamA.layer.borderWidth = 0
        teamA.titleLabel?.textColor = .gray200
        
        teamB.layer.borderColor = UIColor.green700.cgColor
        teamB.layer.borderWidth = 1
        teamB.titleLabel?.textColor = .white
        
        participantsTableView.reloadData()
        loadTotalParticipants()
    }
    
    private lazy var inputClassroom : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.textColor = .gray300
       
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.attributedPlaceholder = NSAttributedString(string: "Nome do participante", attributes: [
            .foregroundColor: UIColor.gray300,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
        ])
      
        return textField
    } ()
    
    private lazy var participantsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "participantCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private func initialData() {
        classroomTitle.text = classroom.title
        
        loadTotalParticipants()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        teamA.layer.borderColor = UIColor.green700.cgColor
        
        // Do any additional setup after loading the view.
            
        setupNavigation()
        addSubviews()
        setupConstraints()
        
        initialData()
    }
    
    
    public func setupNavigation() {
        navigationController?.navigationBar.isHidden = true
    }

    private func addSubviews() {
        view.addSubview(headerStack)
        view.addSubview(contentView)
        view.addSubview(inputContentView)
        view.addSubview(participantsTableView)
        view.addSubview(teamA)
        view.addSubview(teamB)
        view.addSubview(totalParticipants)
}
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
          
            contentView.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 32),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        
            inputClassroom.heightAnchor.constraint(equalToConstant: 48),
            inputContentView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 48),
            inputContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            inputContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            inputClassroom.leadingAnchor.constraint(equalTo: inputContentView.leadingAnchor, constant: 12),
            addButton.widthAnchor.constraint(equalToConstant: 32),
            
            participantsTableView.topAnchor.constraint(equalTo: teamA.bottomAnchor, constant: 16),
            participantsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            participantsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            participantsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
          
            
            teamA.topAnchor.constraint(equalTo: inputContentView.bottomAnchor, constant: 32),
            teamA.widthAnchor.constraint(equalToConstant: 70),
            teamA.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            teamB.leadingAnchor.constraint(equalTo: teamA.trailingAnchor, constant: 12),
            teamB.widthAnchor.constraint(equalToConstant: 70),
            teamB.topAnchor.constraint(equalTo: inputContentView.bottomAnchor, constant: 32),
            
            totalParticipants.topAnchor.constraint(equalTo: inputContentView.bottomAnchor, constant: 32),
            totalParticipants.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            totalParticipants.centerYAnchor.constraint(equalTo: teamB.centerYAnchor)
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

extension AddParticipantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classroom.participants.filter({$0.team == selectedTeam}).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "participantCell", for: indexPath)
        
        var participants = classroom.participants.filter({$0.team == selectedTeam})
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = participants[indexPath.row].name
        configuration.textProperties.color = .white
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.contentConfiguration = configuration
        
        return cell
    }
    
    
}
