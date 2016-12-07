//
//  DataModel.swift
//  pm1
//
//  Created by Jean-Jean Wei on 2016-12-05.
//  Copyright © 2016 Jean-Jean Wei. All rights reserved.
//

import Foundation

enum Levels: String
{
    case Addition = "Addition"
    case Subtraction = "Subtraction"
    case Multiplication = "Multiplication"
    case Division = "Division"
}

typealias Team = (
    teamId: Int64?,
    city: String?,
    nickName: String?,
    abbreviation: String?
)

typealias Exam = (
    examId: Int64?,
    firstName: String?,
    lastName: String?,
    score: Int?,
    duration: Int64?,
    totalQuestions: Int?,
    level: Levels?
)
