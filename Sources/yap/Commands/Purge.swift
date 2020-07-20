// Purge.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import ArgumentParser
import Foundation

struct Purge: ParsableCommand {
    static let configuration: CommandConfiguration = .init(
        commandName: NSLocalizedString(
            "purge",
            bundle: .module,
            comment: "Purge command"),
        abstract: NSLocalizedString(
            "Purge everything in a list.",
            bundle: .module,
            comment: "Purge command description"),
        shouldDisplay: true)
    
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(
            NSLocalizedString("Purge both complete and pending items.",
                              bundle: .module,
                              comment: "Argument help")))
    private var all: Bool
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
                                                    "Show less detail.",
                                                    bundle: .module,
                                                    comment: "Argument help")))
    private var silent: Bool
    
    
    func run() throws {
        try program.verifyFileExists()
        try program.checkEmptyList()
        
        if all {
            program.purgeAll(silent)
        } else {
            try program.checkEmptyCompleteList()
            program.purgeCompleted(silent)
        }
    }
}
