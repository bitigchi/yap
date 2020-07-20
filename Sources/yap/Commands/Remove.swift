// Remove.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import ArgumentParser
import Foundation

struct Remove: ParsableCommand {
    static let configuration: CommandConfiguration = .init(
        commandName: NSLocalizedString(
            "rm",
            bundle: .module,
            comment: "Remove command"),
        abstract: NSLocalizedString(
            "Remove individual items.",
            bundle: .module,
            comment: "Command description"),
        shouldDisplay: true)
    
    
    @Argument(help: ArgumentHelp(NSLocalizedString(
                                    "To-do item number",
                                    bundle: .module,
                                    comment: "Help text")))
    private var number: Int
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(NSLocalizedString(
                                                    "Show less detail.",
                                                    bundle: .module,
                                                    comment: "Argument help")))
    var silent: Bool
    

    func run() throws {
        try program.verifyFileExists()
        try program.checkEmptyList()
        try program.notValidItemNumber(number)
        program.removeItem(number, silent)
    }
}
