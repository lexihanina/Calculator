//
//  ResultsTableViewController.swift
//  Calculator
//
//  Created by Lexi Hanina on 2/12/22.
//

import UIKit

protocol ResultsDelegate: AnyObject {
    func getOperationsResults() -> ResultsStruct
}

class ResultsTableViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var operationResults: ResultsStruct?
    private var sortedDict: [String]?
    private weak var delegate: ResultsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = tabBarController?.viewControllers?.first as? ResultsDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        operationResults = delegate?.getOperationsResults()
        sortedDict = operationResults?.resultsDictionary.keys.sorted(by: <)
        tableView.reloadData()
    }
}

extension ResultsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let numberOfSections = sortedDict?.count ?? 0
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = sortedDict?[section] ?? ""
        
        return title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let key = sortedDict?[section] {
            let numberOfRows = operationResults?.resultsDictionary[key]?.count
            return numberOfRows ?? 0
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsTableViewCell") as? ResultsTableViewCell else { return UITableViewCell() }
        
        guard let key = sortedDict?[indexPath.section] else { return UITableViewCell() }
        let array = operationResults?.resultsDictionary[key]
        guard let text = array?[indexPath.row]  else { return UITableViewCell() }
        cell.setupCellLabel(withText: text)
        
        return cell
    }
}

