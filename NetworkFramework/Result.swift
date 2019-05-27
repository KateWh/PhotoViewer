//
//  Result.swift
//  NetworkFramework
//
//  Created by ket on 5/5/19.
//  Copyright © 2019 ket. All rights reserved.
//

import Foundation

// For send the result of the query.
public enum Result<Type> {
    case success(Type)
    case failure(Error)
}
