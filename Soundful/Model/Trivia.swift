//
//  Trivia.swift
//  Soundful
//
//  Created by Thomas Lai on 6/3/20.
//  Copyright © 2020 Thomas Lai. All rights reserved.
//
import Foundation

protocol TriviaDelegate {
    func didUpdateQuestion(_ trivia: Trivia, _ model: TriviaModel)
    func didFailWithError(error: Error)
}
struct Trivia {
    var score = 0
    
    let triviaURL = "https://opentdb.com/api.php?amount=1&type=boolean"

    var delegate: TriviaDelegate?
    
    func getQuestion(difficulty: String) {
        let urlString = "\(triviaURL)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let model = self.parseJSON(safeData) {
                        self.delegate?.didUpdateQuestion(self, model)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> TriviaModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(TriviaData.self, from: data)
            
            let q = decodedData.results[0].question
            let a = decodedData.results[0].correct_answer
            
            let tModel = TriviaModel(question: q, answer: a)
            return tModel
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
