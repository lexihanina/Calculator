//
//  ViewController.swift
//  Calculator
//
//  Created by Lexi Hanina on 2/8/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var acButton: UIButton!
    @IBOutlet private weak var positivNegativButton: UIButton!
    @IBOutlet private weak var percentageButton: UIButton!
    @IBOutlet private weak var devideButton: UIButton!
    @IBOutlet private weak var multiplyButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var equalButton: UIButton!
    @IBOutlet private weak var dotButton: UIButton!
    @IBOutlet private weak var zeroButton: UIButton!
    @IBOutlet private weak var oneButton: UIButton!
    @IBOutlet private weak var twoButton: UIButton!
    @IBOutlet private weak var threeButton: UIButton!
    @IBOutlet private weak var fourButton: UIButton!
    @IBOutlet private weak var fiveButton: UIButton!
    @IBOutlet private weak var sixButton: UIButton!
    @IBOutlet private weak var sevenButton: UIButton!
    @IBOutlet private weak var eightButton: UIButton!
    @IBOutlet private weak var nineButton: UIButton!
    @IBOutlet private weak var squareRootButton: UIButton!
    @IBOutlet private weak var squareButton: UIButton!
    @IBOutlet private weak var moduloButton: UIButton!
    @IBOutlet private weak var fuctorialButton: UIButton!
    @IBOutlet private weak var twoZeroButton: UIButton!
    @IBOutlet private weak var resultLabel: UILabel!
    
    private var firstNum: Float = 0
    private var secondNum: Float = 0
    private var result: Float?
    private var numButtonsArray: [UIButton] = []
    private var symbolsArray: [UIButton] = []
    private var operation: Operation = .none
    private var status: Bool = true
    private var resultString: String = ""
    private var resultForTableView: ResultsStruct = ResultsStruct()
    
    enum Operation {
        case devide
        case multiply
        case minus
        case plus
        case none
        case modulo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numButtonsArray.append(contentsOf: [zeroButton, oneButton, twoButton, threeButton,
                                            fourButton, fiveButton, sixButton, sevenButton,
                                            eightButton, nineButton, dotButton])
        symbolsArray.append(contentsOf: [positivNegativButton, percentageButton,
                                         devideButton, multiplyButton, minusButton,
                                         plusButton, equalButton, acButton, squareRootButton, squareButton, moduloButton, fuctorialButton, twoZeroButton])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonsCornerRadius()
        
    }
    
    @IBAction private func didTappedNum(_ sender: UIButton) {
        guard let num = sender.currentTitle else { return }
        
        if resultLabel.text == "0" || status {
            resultLabel.text = num
            status = false
        } else if let text = resultLabel.text, !status {
            resultLabel.text = "\(text)\(num)"
        }
    }
    
    @IBAction private func didTapDot(_ sender: Any) {
        guard let text = resultLabel.text else { return }
        if !text.contains(".") {
            resultLabel.text = "\(text)."
        } else {
            return
        }
    }
    
    @IBAction private func didTapOperation(_ sender: UIButton) {
        guard let operationType = sender.currentTitle else { return }
        
        if let text = resultLabel.text, let value = Float(text), firstNum == 0 {
            firstNum = value
            resultString += "\(chechIfInt(num: firstNum)) "
        } else if let text = resultLabel.text, let value = Float(text), firstNum != 0 {
            secondNum = value
            resultString += "\(chechIfInt(num: secondNum)) "
        }
        
        switch operationType {
            case "+":
                operation = .plus
                resultString += "\(operationType) "
                result = firstNum + secondNum
                firstNum = result ?? 0
                resultLabel.text = chechIfInt(num: result ?? 0)
                status = true
            case "-":
                operation = .minus
                resultString += "\(operationType) "
                result = firstNum - secondNum
                firstNum = result ?? 0
                resultLabel.text = chechIfInt(num: result ?? 0)
                status = true
            case "x":
                operation = .multiply
                resultString += "\(operationType) "
                if secondNum == 0 {
                    result = firstNum
                } else {
                    result = firstNum * secondNum
                }
                firstNum = result ?? 0
                resultLabel.text = chechIfInt(num: result ?? 0)
                status = true
            case "÷":
                operation = .devide
                resultString += "\(operationType) "
                if secondNum == 0 {
                    result = firstNum
                } else {
                    result = firstNum / secondNum
                }
                firstNum = result ?? 0
                resultLabel.text = chechIfInt(num: result ?? 0)
                status = true
            case "%":
                result = firstNum / 100
                resultString = "1% of \(chechIfInt(num: firstNum)) = \(result ?? 0)"
                addToResultArray(forKey: "Percent")
                resultLabel.text = chechIfInt(num: result ?? 0)
                prepareForNextOperation()
            case "+/-":
                result = firstNum * -1
                resultString = "\(chechIfInt(num: firstNum))  inverted is \(chechIfInt(num: result ?? 0))"
                addToResultArray(forKey: "Inverce")
                resultLabel.text = chechIfInt(num: result ?? 0)
                prepareForNextOperation()
            case "√":
                result = sqrt(firstNum)
                resultString = "\(operationType)\(chechIfInt(num: firstNum)) = \(chechIfInt(num: result ?? 0))"
                addToResultArray(forKey: "Square root")
                resultLabel.text = chechIfInt(num: result ?? 0)
                prepareForNextOperation()
            case "x²":
                result = firstNum * firstNum
                resultString = "\(operationType) of \(chechIfInt(num: firstNum)) =  \(chechIfInt(num: result ?? 0))"
                addToResultArray(forKey: "Square")
                resultLabel.text = chechIfInt(num: result ?? 0)
                prepareForNextOperation()
            case "mod":
                operation = .modulo
                resultString += "modulo "
                if secondNum == 0 {
                    result = firstNum
                    resultLabel.text = chechIfInt(num: firstNum)
                } else {
                    let intResult = Int(firstNum) % Int(secondNum)
                    resultLabel.text = "\(intResult)"
                }
                status = true
            case "x!":
                let intResult = calculateFucktorial(from: Int(firstNum))
                resultString = "Factorial of \(Int(firstNum)) = \(intResult)"
                addToResultArray(forKey: "Factorial")
                resultLabel.text = "\(intResult)"
                prepareForNextOperation()
            case "=":
                equalOperation()
            default:
                break
        }
    }
    
    @IBAction private func didTapAC(_ sender: UIButton) {
        resultLabel.text = "0"
        firstNum = 0
        secondNum = 0
        operation = .none
    }
    
    @IBAction func didTapTwoZeros(_ sender: Any) {
        if let text = resultLabel.text {
            resultLabel.text = text + "00"
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { _ in
            
        } completion: { _ in
            self.buttonsCornerRadius()
        }
        super.willTransition(to: newCollection, with: coordinator)
    }
    
    private func buttonsCornerRadius() {
        let cornerRadius = acButton.bounds.height / 2
        
        numButtonsArray.forEach { button in
            button.layer.cornerRadius = cornerRadius
            button.clipsToBounds = true
        }
        
        symbolsArray.forEach { button in
            button.layer.cornerRadius = cornerRadius
            button.clipsToBounds = true
        }
    }
    
    private func chechIfInt(num: Float) -> String {
        let number = Int(num)
        
        if num - Float(number) > 0 {
            return "\(num)"
        } else {
            return "\(number)"
        }
    }
    
    private func calculateFucktorial(from num: Int) -> Int {
        guard num <= 20 else { return 0 }
        if num == 1 {
            return num
        }
        return num * calculateFucktorial(from: num - 1)
    }
    
    private func equalOperation() {
        switch operation {
            case .plus:
                result = firstNum + secondNum
                addEqualToString(result: result ?? 0, forKey: "Plus")
                resultLabel.text = chechIfInt(num: result ?? 0)
                prepareForNextOperation()
            case .minus:
                result = firstNum - secondNum
                addEqualToString(result: result ?? 0, forKey: "Minus")
                resultLabel.text = chechIfInt(num: result ?? 0)
                prepareForNextOperation()
            case .multiply:
                result = firstNum * secondNum
                addEqualToString(result: result ?? 0, forKey: "Multiply")
                resultLabel.text = chechIfInt(num: result ?? 0)
                prepareForNextOperation()
            case .devide:
                result = firstNum / secondNum
                addEqualToString(result: result ?? 0, forKey: "Devide")
                resultLabel.text = chechIfInt(num: result ?? 0)
                prepareForNextOperation()
            case .modulo:
                let intResult = Int(firstNum) % Int(secondNum)
                addEqualToString(result: Float(intResult), forKey: "Modulo")
                resultLabel.text = "\(intResult)"
                prepareForNextOperation()
            default:
                break
        }
    }
    
    private func addEqualToString(result: Float, forKey: String) {
        resultString += "= \(chechIfInt(num: result))"
        addToResultArray(forKey: forKey)
    }
    
    private func addToResultArray(forKey: String) {
        if let _ = resultForTableView.resultsDictionary[forKey] {
            resultForTableView.resultsDictionary[forKey]!.append(resultString)
        } else {
            resultForTableView.resultsDictionary[forKey] = [resultString]
        }
        resultString = ""
    }
    
    func getResult() -> String? {
        if let result = result {
            return chechIfInt(num: result)
        }
        return nil
    }
    
    func prepareForNextOperation() {
        status = true
        firstNum = 0
        secondNum = 0
    }
    
}

extension ViewController: ResultsDelegate {
    func getOperationsResults() -> ResultsStruct {
        return resultForTableView
    }
}
