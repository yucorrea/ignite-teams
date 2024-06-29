//
//  HomeViewController.swift
//  Ignite Teams
//
//  Created by Yuri Correa on 21/06/24.
//

import UIKit

protocol DataPassingDelegate: AnyObject {
    func addNewClassroom(title: String)
    func addParticipantInClassroom(classroomId: Int, participants: [Participant])
}

class HomeViewController: UIViewController{
    private var classrooms: [Classroom] = []
    
    private lazy var headerLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.logo
        
        return imageView
    }()
    
    private lazy var classroomTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.text = "Turmas"
        return label
    }()
    
    private lazy var classroomDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white.withAlphaComponent(0.4)
        label.text = "jogue com a sua turma"
        return label
    }()
    
    @objc func createNewClassroom() {
        let view = NewClassroomViewController()
        
        view.delegate = self
        navigationController?.pushViewController(view, animated: true)
    }
    
    private lazy var newClassroomButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Criar nova turma", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .green700
        button.addTarget(self, action: #selector(createNewClassroom), for: .touchDown)
        button.layer.cornerRadius = 6
        return button
    }()
    
    
    private lazy var classroomsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ClassroomTableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        // Do any additional setup after loading the view.
        
        addSubviews()
        setupConstraints()
    }
    

    private func addSubviews() {
        view.addSubview(headerLogo)
        view.addSubview(classroomTitle)
        view.addSubview(classroomDescription)
        view.addSubview(classroomsTableView)
        view.addSubview(newClassroomButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLogo.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            classroomTitle.topAnchor.constraint(equalTo: headerLogo.bottomAnchor, constant: 32),
            classroomTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            classroomDescription.topAnchor.constraint(equalTo: classroomTitle.bottomAnchor, constant: 12),
            classroomDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            classroomsTableView.topAnchor.constraint(equalTo: classroomDescription.bottomAnchor, constant: 16),
            classroomsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            classroomsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            classroomsTableView.bottomAnchor.constraint(equalTo: newClassroomButton.topAnchor, constant: -16),
            newClassroomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            newClassroomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            newClassroomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            newClassroomButton.heightAnchor.constraint(equalToConstant: 55)
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

extension HomeViewController: DataPassingDelegate {
    func addParticipantInClassroom(classroomId: Int, participants: [Participant]) {
        if let index = classrooms.firstIndex(where: {$0.id == classroomId}) {
            classrooms[index].participants = participants
        }
    }
    
    func addNewClassroom(title: String) {
        let id = classrooms.count + 1
        
        classrooms.append(Classroom(id: id, title: title, participants: []))
        classroomsTableView.reloadData()
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classrooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? ClassroomTableViewCell {
            cell.selectionStyle = .none
            cell.configureCell(classroom: classrooms[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let view = AddParticipantViewController(classroom: classrooms[indexPath.row])
        view.delegate = self
        
        navigationController?.pushViewController(view, animated: true)
    }
  
}
