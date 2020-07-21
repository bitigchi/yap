//
//  File.swift
//  
//
//  Created by Emir SARI on 20.07.2020.
//

import Foundation

enum ValidationError: Error {
    case alreadyInList
    case alreadyCompleted
    case emptyTodo
    case emptyList
    case notValid
    case noFile
    case noArgument
    case noCompletedItem
}

extension ValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .alreadyInList:
            return NSLocalizedString(
                "Item already in the list.",
                bundle: program.bundle ?? .module,
                comment: "Error message")
            
        case .alreadyCompleted:
            return NSLocalizedString(
                "Item(s) already completed.",
                bundle: program.bundle ?? .module,
                comment: "Error message")
            
        case .emptyTodo:
            return NSLocalizedString(
                "You cannot enter an empty to-do.",
                bundle: program.bundle ?? .module,
                comment: "Error message")
            
        case .emptyList:
            return NSLocalizedString(
                """
                There is nothing on the list!
                Being productive, eh?
                """,
                bundle: program.bundle ?? .module,
                comment: "No to-do message")
            
        case .notValid:
            return NSLocalizedString(
                """
                Number not valid.
                Type \"yap ls\" to see the correct item number.
                """,
                bundle: program.bundle ?? .module,
                comment: "Error message")
            
        case .noFile:
            return NSLocalizedString(
                """
                You haven't added a to-do item yet.
                Use \"yap add\" to use stdin or use
                \"yap add <to-do>\".
                """,
                bundle: program.bundle ?? .module,
                comment: "Error message")
            
        case .noCompletedItem:
            return NSLocalizedString(
                """
                There are no completed items.
                Mark some items as \"complete\" first.
                """,
                bundle: program.bundle ?? .module,
                comment: "Error message")

        case .noArgument:
            return NSLocalizedString(
                """
                No argument specified.
                Add [--help] to see available arguments.
                """,
                bundle: program.bundle ?? .module,
                comment: "Error message")
        }
    }
}

