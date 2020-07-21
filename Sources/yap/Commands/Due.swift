// Due.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import ArgumentParser
import Foundation

struct Due: ParsableCommand {
    static let configuration: CommandConfiguration = .init(
        commandName: "due",
        abstract: NSLocalizedString(
            "Add due dates.",
            bundle: program.bundle ?? .module,
            comment: "Command description"),
        shouldDisplay: true)
    
    
    @Argument(help: ArgumentHelp(NSLocalizedString(
                                    "To-do item number.",
                                    bundle: program.bundle ?? .module,
                                    comment: "Help text")))
    private var number: Int
    
    @Argument(help: ArgumentHelp(NSLocalizedString(
                                    "Due date.",
                                    bundle: program.bundle ?? .module,
                                    comment: "Help text")))
    private var dateStr: String
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
                                                    "Show less detail.",
                                                    bundle: program.bundle ?? .module,
                                                    comment: "Argument help")))
    private var silent = false
    
    
    func run() throws {
        try program.verifyFileExists()
        try program.checkEmptyList()
        try program.checkEmptyRemainingList()
        program.markDue(number, dateStr, silent)
    }
}
