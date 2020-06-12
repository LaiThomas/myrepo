//
//  TriviaData.swift
//  Soundful
//
//  Created by Thomas Lai on 6/3/20.
//  Copyright © 2020 Thomas Lai. All rights reserved.
//

import Foundation

struct TriviaData: Codable{
    let results: [Results]
   
}
struct Results: Codable {
    let question: String
    let correct_answer: String
}


