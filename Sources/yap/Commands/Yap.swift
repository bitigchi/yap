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
            "Simple to-do list",
            bundle: program.bundle ?? .module,
            comment: "Program description"),
        version: "yap, " +
            NSLocalizedString("version ",
                              bundle:program.bundle ?? .module,
                              comment: "Version info") + "0.3",
        shouldDisplay: true,
        subcommands: [Add.self,
                      Complete.self,
                      Due.self,
                      List.self,
                      Purge.self,
                      Remove.self])
}
