//
//  Flow.swift
//  QuizEngine
//
//  Created by Seab Jackson on 4/19/22.
//

import Foundation

protocol Router {
    func routeTo(question: String)
}

class Flow {
    let router: Router
    let questions: [String]
    
    init(questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if !questions.isEmpty {
            router.routeTo(question: "")
        }
    }
    
}
