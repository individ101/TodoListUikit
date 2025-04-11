//
//  CustomSearchBar.swift
//  TodoListWork
//
//  Created by Abubakar Bibulatov on 10.04.2025.
//

import UIKit

class CustomSearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        placeholder = "Find todo"
        translatesAutoresizingMaskIntoConstraints = false
        searchBarStyle = .minimal
        barTintColor = .clear
        
        if let textField = value(forKey: "searchTextField") as? UITextField {
            textField.backgroundColor = UIColor(named: "textFieldBackground")
            textField.textColor = .white
            textField.tintColor = .systemBlue
            textField.attributedPlaceholder = NSAttributedString(
                string: "Find todo",
                attributes: [.foregroundColor: UIColor(named: "texFPlaceHolder") ?? .gray]
            )
            
            if let clearButton = textField.value(forKey: "_clearButton") as? UIButton {
                let clearImage = clearButton.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
                clearButton.setImage(clearImage, for: .normal)
                clearButton.tintColor = UIColor(named: "texFPlaceHolder") ?? .systemGray2
            }
            
            let searchImage = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate)
            setImage(searchImage, for: .search, state: .normal)
            textField.leftView?.tintColor = UIColor(named: "texFPlaceHolder") ?? .systemGray2
        }
    }
    
}

