//
//  AddViewController.swift
//  TodoListWork
//
//  Created by Abubakar Bibulatov on 10.04.2025.
//

import UIKit

class AddViewController: UIViewController {
    
    private let manager = CoreDataManager.shared
    var todo: TodoList?
    
    lazy var titleField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter your todo"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.heightAnchor.constraint(equalToConstant: 60).isActive = true
        tf.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        tf.backgroundColor = .systemGray
        
        return tf
    }()
    
    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.heightAnchor.constraint(equalToConstant: 100).isActive = true
        tv.font = UIFont.systemFont(ofSize: 12)
        tv.backgroundColor = .systemGray
        
        return tv
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton(primaryAction: action)
        btn.setTitle("Save", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    lazy var action = UIAction { _ in
        if self.todo == nil {
            self.manager.addNewTodo(title: self.titleField.text ?? "", text: self.textView.text ?? "")
        } else {
            self.todo?.updateTodo(title: self.titleField.text ?? "", text: self.textView.text ?? "")
        }
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleField)
        view.addSubview(textView)
        view.addSubview(btn)
        view.backgroundColor = .white
        title = "Add Todo"
        
        setupConstraints()
        
        if todo != nil {
            title = "Edit Todo"
            titleField.text = todo?.title
            textView.text = todo?.text
        } else {
            title = "Add Todo"
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            textView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            btn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            btn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
}
