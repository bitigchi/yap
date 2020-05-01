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
            NSLocalizedString("version ", comment: "Version info") + "0.0.1",
        shouldDisplay: true,
        subcommands: [Add.self,
                      Complete.self,
                      List.self,
                      Purge.self,])
}
