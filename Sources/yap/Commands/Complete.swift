// Complete.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import ArgumentParser
import Foundation

struct Complete: ParsableCommand {
    static let configuration: CommandConfiguration = .init(
        commandName: NSLocalizedString(
            "cm", comment: "Complete command"),
        abstract: NSLocalizedString(
            "Mark item(s) as complete.", comment: "Command description"),
        shouldDisplay: true)
    

    @Argument(help: ArgumentHelp(NSLocalizedString(
        "To-do item number.", comment: "Help text")))
    private var numbers: [Int]
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
        "Mark item as pending.", comment: "Help text")))
    private var pending: Bool
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
        "Show less detail.", comment: "Argument help")))
    private var silent: Bool
    

    func run() throws {
        try program.checkEmptyList()
        
        // Check if all array elements are valid
        for number in numbers {
            try program.notValidItemNumber(number)
        }
        
        // If not trying to undo, allow error
        if pending == false {
            try program.alreadyCompleted(numbers)
        }
        program.markAsComplete(numbers, pending, silent)
    }
}
