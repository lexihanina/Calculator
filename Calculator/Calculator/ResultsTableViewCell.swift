//
//  ResultsTableViewCell.swift
//  Calculator
//
//  Created by Lexi Hanina on 2/12/22.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    @IBOutlet private weak var resultsLabel: UILabel!
     
    func setupCellLabel(withText: String) {
        resultsLabel.text = withText
    }
}
