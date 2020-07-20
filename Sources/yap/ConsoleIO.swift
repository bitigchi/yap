// ConsoleIO.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import Foundation

enum OutputType {
    case error
    case standard
}

class ConsoleIO {
    func writeMessage(_ message: String, to: OutputType = .standard) {
        switch to {
        case .standard:
            print("\u{001B}[;m\(message)")
        case .error:
            fputs("\u{001B}[0;31m\(message)\n", stderr)
        }
    }
    
    func writeError(_ error: LocalizedError) -> LocalizedError {
        fputs("\u{001B}[0;31m\(error.errorDescription ?? "")\n", stderr)
        return error
    }
}
