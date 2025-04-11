//
//  TodoTableViewCell.swift
//  TodoListWork
//
//  Created by Abubakar Bibulatov on 11.04.2025.
//

import UIKit

final class TodoCell: UITableViewCell {
    
    static let identifier = "TodoCell"
    
    private var todo: TodoList?
    var checkmarkTapped: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var stackLabels: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, dateLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        selectionStyle = .none
        backgroundColor = .black
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(checkmarkTappedAction))
            checkmarkImageView.isUserInteractionEnabled = true
            checkmarkImageView.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Добавляем элементы на ячейку
        contentView.addSubview(checkmarkImageView)
        contentView.addSubview(stackLabels)
        
        // Настройка Auto Layout
        NSLayoutConstraint.activate([
            // Checkmark
            checkmarkImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            checkmarkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24),
            
            stackLabels.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackLabels.leadingAnchor.constraint(equalTo: checkmarkImageView.trailingAnchor, constant: 12),
            stackLabels.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackLabels.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    @objc private func checkmarkTappedAction() {
        checkmarkTapped?()
    }
    
    private func animateCheckmark(isDone: Bool) {
        UIView.transition(with: checkmarkImageView, duration: 0.3, options: .transitionFlipFromLeft) {
            if isDone {
                self.checkmarkImageView.image = UIImage(systemName: "checkmark.circle")
            } else {
                self.checkmarkImageView.image = UIImage(systemName: "circle")
            }
        }
    }
    
    func configure(with todo: TodoList) {
        self.todo = todo
        
        dateLabel.text = todo.formattedDate
        
        if todo.isCompleted {
            // Используем attributedText для заголовка с зачеркиванием
            titleLabel.attributedText = NSAttributedString(
                string: todo.title ?? "",
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            descriptionLabel.text = todo.text
            
            checkmarkImageView.image = UIImage(systemName: "checkmark.circle")
            checkmarkImageView.tintColor = .systemYellow
            descriptionLabel.textColor = .systemGray
            titleLabel.textColor = .systemGray
        } else {
            // Просто устанавливаем обычный текст без атрибутов
            titleLabel.attributedText = nil
            titleLabel.text = todo.title
            descriptionLabel.text = todo.text
            
            checkmarkImageView.image = UIImage(systemName: "circle")
            checkmarkImageView.tintColor = .systemGray
            descriptionLabel.textColor = .white
            titleLabel.textColor = .white
        }
    }
}
