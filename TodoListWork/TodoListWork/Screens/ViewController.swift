//
//  ViewController.swift
//  TodoListWork
//
//  Created by Abubakar Bibulatov on 10.04.2025.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let manager = CoreDataManager.shared
    private let searchBar = CustomSearchBar()
    private var filteredTodos: [TodoList] = []
    private var isSearching = false
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.separatorColor = .systemGray
        table.rowHeight = UITableView.automaticDimension
        table.dataSource = self
        table.delegate = self
        table.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
        
        return table
    }()
    
    lazy private var addButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "addButton"), for: .normal)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        setupConstraints()
        
        searchBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func setupConstraints() {
        let headerView = UIView()
        headerView.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: headerView.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            searchBar.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            addButton.widthAnchor.constraint(equalToConstant: 60),
            addButton.heightAnchor.constraint(equalToConstant: 60),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
        headerView.backgroundColor = .black
        
        tableView.tableHeaderView = headerView
    }
    
    @objc private func addButtonTapped() {
        let addTodoVC = AddViewController()
        navigationController?.pushViewController(addTodoVC, animated: true)
    }
}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       isSearching ? filteredTodos.count : manager.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier, for: indexPath) as? TodoCell else { return UITableViewCell() }
        
        let task = isSearching ? filteredTodos[indexPath.row] : manager.todos[indexPath.row]
        cell.configure(with: task)
        cell.checkmarkTapped = { [weak self] in
                guard let self else { return }
                task.isCompleted.toggle()
                self.manager.saveContext()
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddViewController()
        vc.todo = manager.todos[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todo = manager.todos[indexPath.row]
            todo.deleteTodo()
            manager.todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchText.trimmingCharacters(in: .whitespaces).lowercased()
        
        if searchText.isEmpty {
            isSearching = false
            filteredTodos = []
        } else {
            isSearching = true
            filteredTodos = manager.todos.filter { todo in
                return todo.title?.lowercased().contains(searchText) ?? false ||
                todo.text?.lowercased().contains(searchText) ?? false
            }
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
            isSearching = false
            filteredTodos = []
            tableView.reloadData()
            searchBar.resignFirstResponder()
        }
    
}
