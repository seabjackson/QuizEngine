//
//  File.swift
//  QuizEngine
//
//  Created by Seab Jackson on 5/11/22.
//

import Foundation

public protocol Router {
    associatedtype Answer
    associatedtype Question: Hashable
    typealias AnswerCallback = (Answer) -> Void
    
    func routeTo(question: Question, answerCallback: @escaping AnswerCallback)
    func routeTo(results: Result<Question, Answer>)
}
