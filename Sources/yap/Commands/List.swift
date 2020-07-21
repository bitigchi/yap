// List.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import ArgumentParser
import Foundation

struct List: ParsableCommand {
    static let configuration: CommandConfiguration = .init(
        commandName: "ls",
        abstract: NSLocalizedString(
            "List items.",
            bundle: program.bundle ?? .module,
            comment: "List command description"),
        shouldDisplay: true)
    
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
                                                    "Show completed items.",
                                                    bundle: program.bundle ?? .module,
                                                    comment: "Argument help")))
    private var complete = false
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(
            NSLocalizedString("Show both completed and pending items.",
                              bundle: program.bundle ?? .module,
                              comment: "Argument help")))
    private var all = false
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
                                                    "Hide due date.",
                                                    bundle: program.bundle ?? .module,
                                                    comment: "Argument help")))
    private var noDate = false

    
    func run() throws {
        let completeHeader = "\n" + NSLocalizedString(
            "Recently completed:",
            bundle: program.bundle ?? .module,
            comment: "Completed to-do items") + "\n"
        let pendingHeader = "\n" + NSLocalizedString(
            "Pending items:",
            bundle: program.bundle ?? .module,
            comment: "Unfinished to-do header") + "\n"
        
        try program.verifyFileExists()
        try program.checkEmptyList()
        
        if complete {
            try program.checkEmptyCompleteList()
            consoleIO.writeMessage(completeHeader)
            program.list(complete: true, noDate)
        } else if all {
            consoleIO.writeMessage(completeHeader)
            program.list(complete: true, noDate)
            consoleIO.writeMessage(pendingHeader)
            program.list(complete: false, noDate)
        } else {
            try program.checkEmptyRemainingList()
            consoleIO.writeMessage(pendingHeader)
            program.list(complete: false, noDate)
        }
    }
}
