// Yap.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import ArgumentParser
import Foundation

struct Yap: ParsableCommand {
    static let configuration: CommandConfiguration = .init(
        commandName: "yap",
        abstract: NSLocalizedString(
            "Simple to-do list", comment: "Program description"),
        version: "yap, " +
            NSLocalizedString("version ", comment: "Version info") + "0.1",
        shouldDisplay: true,
        subcommands: [Add.self,
                      Complete.self,
                      Purge.self,
                      Remove.self])
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
        "Show completed items.", comment: "Argument help")))
    private var complete: Bool
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
        "Show both completed and remaining items.", comment: "Argument help")))
    private var all: Bool
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
        "Hide due date.", comment: "Argument help")))
    private var noDate: Bool
    
    
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
