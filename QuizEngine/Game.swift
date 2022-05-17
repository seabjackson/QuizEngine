//
//  Game.swift
//  QuizEngine
//
//  Created by Seab Jackson on 5/16/22.
//

import Foundation


public func startGame<Question: Hashable, Answer, R: Router>(questions: [Question], router: R, correctAnswers: [Question: Answer]) where R.Question == Question, R.Answer == Answer {
    
}
