// TodoItem.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import Foundation
    
struct TodoItem: Codable, Equatable {
    let id = UUID()
    var name: String
    var complete: Bool
    var addDate: Date
    var dueDate: Date?

    enum CodingKeys: String, CodingKey {
        case id, name, complete, addDate, dueDate
    }
}
