// Purge.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import ArgumentParser
import Foundation

struct Purge: ParsableCommand {
    static let configuration: CommandConfiguration = .init(
        commandName: "purge",
        abstract: NSLocalizedString("Purge completed items (default).",
                                    bundle: program.bundle ?? .module,
                                    comment: "Purge command description"),
        shouldDisplay: true)
    
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(
            NSLocalizedString("Purge both complete and pending items.",
                              bundle: program.bundle ?? .module,
                              comment: "Argument help")))
    private var all = false
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(
            NSLocalizedString("Show less detail.",
                              bundle: program.bundle ?? .module,
                              comment: "Argument help")))
    private var silent = false
    
    
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
