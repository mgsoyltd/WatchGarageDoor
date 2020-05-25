//
//  ServiceError.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 19.11.2019.
//  Copyright © 2019 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import Foundation

public enum ServiceError: Error {
    case responseProblem(String)
    case decodingProblem(String)
    case encodingProblem(String)
    case applicationError(String)
}
