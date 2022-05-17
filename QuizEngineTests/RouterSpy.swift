//
//  RouterSpy.swift
//  QuizEngineTests
//
//  Created by Seab Jackson on 5/16/22.
//

import Foundation
import QuizEngine

class RouterSpy: Router {
    var routedQuestions: [String] = []
    var routedResults: Result<String, String>? = nil
    var answerCallback: ((String) -> Void) = { _ in }
    
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    func routeTo(results: Result<String, String>) {
        routedResults = results
    }
}
