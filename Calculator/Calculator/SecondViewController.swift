//
//  SecondViewController.swift
//  Calculator
//
//  Created Lexi Hanina on 2/11/22.
//

import UIKit



class SecondViewController: UIViewController {

    @IBOutlet private weak var goToNextScreenButton: UIButton!
    
    private var passedResult: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goToNextScreenButton.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let VC = tabBarController?.viewControllers?[0] as? ViewController {
            passedResult = VC.getResult()
        }
    }

    @objc func goToNextScreen() {
        let nextViewController = ThirdViewController()
        nextViewController.resultComplition = { [weak self] in
            return self?.passedResult
        }
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
