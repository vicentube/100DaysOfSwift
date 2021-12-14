//
//  ViewController.swift
//  HWS-Swift100-02
//
//  Created by Vicente on 11/12/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var questionNumber = 0
    let gameQuestions = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showScore))
        
        countries += ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer]
        
        questionNumber += 1
    }
    
    func resetGame(action: UIAlertAction! = nil) {
        questionNumber = 0
        score = 0
        askQuestion()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag])"
            score -= 1
        }
        
        if questionNumber < gameQuestions {
            let alertQuestion = UIAlertController(title: title, message: "Question \(questionNumber)/\(gameQuestions)", preferredStyle: .alert)
            alertQuestion.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(alertQuestion, animated: true)
        } else {
            let alertEnd = UIAlertController(title: title, message: "Game Over - Your final score is \(score)", preferredStyle: .alert)
            alertEnd.addAction(UIAlertAction(title: "New Game", style: .default, handler: resetGame))
            present(alertEnd, animated: true)
        }
        
    }
    
    @objc func showScore() {
        let alertScore = UIAlertController(title: "Score", message: "Your current score is \(score)", preferredStyle: .alert)
        alertScore.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(alertScore, animated: true)
    }
}

