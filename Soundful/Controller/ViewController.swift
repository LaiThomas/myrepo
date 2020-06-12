//
//  ViewController.swift
//  Soundful
//
//  Created by Thomas Lai on 6/3/20.
//  Copyright © 2020 Thomas Lai. All rights reserved.
//

import UIKit

//MARK: - TriviaDelegate
class ViewController: UIViewController, TriviaDelegate {
    
    var tModel: TriviaModel?
    var trivia = Trivia()
    
    func didUpdateQuestion(_ trivia: Trivia, _ model: TriviaModel) {
        DispatchQueue.main.async {
            self.questionLabel.text = model.question
            self.questionLabel.sizeToFit()
            self.tModel = model
            self.scoreLabel.text = "Score: " + String(trivia.score)
        }
    }
    func didFailWithError(error: Error) {
        print(Error.self)
    }
    @IBAction func answerButton(_ sender: UIButton) {
        if tModel?.answer == sender.currentTitle {
            trivia.score += 1
            trivia.getQuestion(difficulty: "easy")
        }
        else {
            trivia.score = 0
            trivia.getQuestion(difficulty: "easy")
        }
    }
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        trivia.delegate = self
        trivia.getQuestion(difficulty: "easy")
        
    }
}
