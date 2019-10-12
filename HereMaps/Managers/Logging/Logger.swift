//
//  Logger.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 07/10/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation
import os.log

struct Logger {
    // TODO: add some logger
    
    public static let shared = Logger()
    private let log: OSLog
    
    private init() {
        log = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "default.logger", category: "here.logger")
    }

    public func logDefault(_ str: StaticString) {
        os_log(.default, log: log, str)
    }
    
    public func logInfo(_ str: StaticString) {
        os_log(OSLogType.info, log: log, str)
    }
    
    public func logDebug(_ str: StaticString) {
        os_log(.debug, log: log, str)
    }
    
    public func logError(_ str: StaticString) {
        os_log(.error, log: log, str)
    }
    
    public func logFault(_ str: StaticString) {
        os_log(.fault, log: log, str)
    }
}
