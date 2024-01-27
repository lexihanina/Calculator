//
//  ThirdViewController.swift
//  Calculator
//
//  Created by Lexi Hanina on 2/11/22.
//

import UIKit

class ThirdViewController: UIViewController {
    
    private var label = UILabel()
    var resultComplition: (() -> String?)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(label)

        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 22)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
        label.text = resultComplition?() ?? "You have not performed any operations in the calculator yet"
    }
    
}

