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
    }
    
}
