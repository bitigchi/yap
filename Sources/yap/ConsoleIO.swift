// ConsoleIO.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import Foundation

enum OutputType {
    case error
    case standard
}

class ConsoleIO {
    func writeMessage(_ message: String, to: OutputType = .standard) {
        switch to {
        case .standard:
            print("\u{001B}[;m\(message)")
        case .error:
            fputs("\u{001B}[0;31m\(message)\n", stderr)
        }
    }
    
    func writeError(_ error: LocalizedError) -> LocalizedError {
        fputs("\u{001B}[0;31m\(error.errorDescription ?? "")\n", stderr)
        return error
    }
}

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
                comment: "Error message")
            
        case .alreadyCompleted:
            return NSLocalizedString(
                "Item(s) already completed.",
                comment: "Error message")
            
        case .emptyTodo:
            return NSLocalizedString(
                "You cannot enter an empty to-do.",
                comment: "Error message")
            
        case .emptyList:
            return NSLocalizedString(
                """
                There is nothing on the list!
                Being productive, eh?
                """,
                comment: "No to-do message")
            
        case .notValid:
            return NSLocalizedString(
                """
                Number not valid.
                Do \"yap list\" to see the correct item number.
                """,
                comment: "Error message")
            
        case .noFile:
            return NSLocalizedString(
                """
                You haven't added a to-do item yet.
                Use "yap add" to use stdin or use
                "yap add <to-do>".
                """,
                comment: "Error message")
            
        case .noCompletedItem:
            return NSLocalizedString(
                """
                There are no completed items.
                Mark some items as \"complete\" first.
                """,
                comment: "Error message")

        case .noArgument:
            return NSLocalizedString(
                """
                No argument specified.
                Add [--help] to see available arguments.
                """,
                comment: "Error message")
        }
    }
}
