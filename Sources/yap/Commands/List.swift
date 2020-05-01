// List.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import ArgumentParser
import Foundation

struct List: ParsableCommand {
    static let configuration: CommandConfiguration = .init(
        commandName: NSLocalizedString(
            "list", comment: "List command"),
        abstract: NSLocalizedString(
            "List items.", comment: "List command description"),
        shouldDisplay: true)
    
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
        "Show completed items.", comment: "Argument help")))
    private var complete: Bool
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
        "Show both completed and remaining items.", comment: "Argument help")))
    private var all: Bool
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
        "Show the creation date.", comment: "Argument help")))
    private var date: Bool
    
    
    func run() throws {
        let completeHeader = "\n" + NSLocalizedString(
                "Recently completed:",
                comment: "Completed to-do items") + "\n"
        let pendingHeader = "\n" + NSLocalizedString(
                "Items pending:",
                comment: "Unfinished to-do header") + "\n"
        
        try program.verifyFileExists()
        try program.checkEmptyList()
        
        if complete {
            try program.checkEmptyCompleteList()
            consoleIO.writeMessage(completeHeader)
            program.list(complete: true, date)
        } else if all {
            consoleIO.writeMessage(completeHeader)
            program.list(complete: true, date)
            consoleIO.writeMessage(pendingHeader)
            program.list(complete: false, date)
        } else {
            consoleIO.writeMessage(pendingHeader)
            program.list(complete: false, date)
        }
    }
}
