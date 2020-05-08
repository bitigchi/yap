// Due.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import ArgumentParser
import Foundation

struct Due: ParsableCommand {
    static let configuration: CommandConfiguration = .init(
        commandName: NSLocalizedString(
            "due", comment: "Due command"),
        abstract: NSLocalizedString(
            "Add due dates.", comment: "Command description"),
        shouldDisplay: true)
    
    
    @Argument(help: ArgumentHelp(NSLocalizedString(
        "To-do item number.", comment: "Help text")))
    private var number: Int
    
    @Argument(help: ArgumentHelp(NSLocalizedString(
        "Due date.", comment: "Help text")))
    private var dateStr: String
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
        "Show less detail.", comment: "Argument help")))
    private var silent: Bool
    
    
    func run() throws {
        try program.verifyFileExists()
        try program.checkEmptyList()
        
        program.markDue(number, dateStr, silent)
    }
}
