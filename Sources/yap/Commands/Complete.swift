// Complete.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import ArgumentParser
import Foundation

struct Complete: ParsableCommand {
    static let configuration: CommandConfiguration = .init(
        commandName: "cm",
        abstract: NSLocalizedString(
            "Mark item as complete.",
            bundle: program.bundle ?? .module,
            comment: "Complete command description"),
        shouldDisplay: true)
    

    @Argument(help: ArgumentHelp(NSLocalizedString(
                                    "To-do item number.",
                                    bundle: program.bundle ?? .module,
                                    comment: "Help text")))
    private var numbers: [Int] = []
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
                                                    "Mark item as pending.",
                                                    bundle: program.bundle ?? .module,
                                                    comment: "Help text")))
    private var pending = false
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
                                                    "Show less detail.",
                                                    bundle: program.bundle ?? .module,
                                                    comment: "Argument help")))
    private var silent = false
    

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
