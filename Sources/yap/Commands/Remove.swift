// Remove.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import ArgumentParser
import Foundation

struct Remove: ParsableCommand {
    static let configuration: CommandConfiguration = .init(
        commandName: "rm",
        abstract: NSLocalizedString(
            "Remove individual items.",
            bundle: program.bundle ?? .module,
            comment: "Command description"),
        shouldDisplay: true)
    
    
    @Argument(help: ArgumentHelp(NSLocalizedString(
                                    "To-do item number.",
                                    bundle: program.bundle ?? .module,
                                    comment: "Help text")))
    private var number: Int
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
                                                    "Show less detail.",
                                                    bundle: program.bundle ?? .module,
                                                    comment: "Argument help")))
    var silent = false
    

    func run() throws {
        try program.verifyFileExists()
        try program.checkEmptyList()
        try program.notValidItemNumber(number)
        program.removeItem(number, silent)
    }
}
