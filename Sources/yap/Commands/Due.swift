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
    private var numbers: [Int]
    
    @Argument(help: ArgumentHelp(NSLocalizedString(
        "Due date.", comment: "Help text")))
    private var dateStr: String
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
        "Show less detail.", comment: "Argument help")))
    private var silent: Bool
    
    
    func run() throws {
        
    }
}

// yap due 1 today
// yap due 2 tomorrow
// yap due 3 nextweek
// yap due 4 nextmonth
// yap due 5 nextyear
// yap due 6 15.03.2020
