//
//  Result.swift
//  QuizEngine
//
//  Created by Seab Jackson on 5/11/22.
//

import Foundation

public struct Result<Question: Hashable, Answer> {
    public let answers: [Question: Answer]
    public let score: Int
}
