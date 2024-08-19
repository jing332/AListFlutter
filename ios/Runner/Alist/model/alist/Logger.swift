//
//  Logger.swift
//  Runner
//
//  Created by apple on 2024/8/16.
//

import Foundation

// Alist 运行日志处理
class Logger {
    static let instance = Logger()

    private init() {
    }

    var listeners = [ListenerProtocol]()

    func addListener(listener: ListenerProtocol) {
        listeners.append(listener)
    }

    func removeListener(listener: ListenerProtocol) {
    
    }

    func log(level: Int, time: String, msg: String) {
        listeners.forEach { element in
            element.onLog(level: level, time: time, msg: msg)
        }
    }
}

public protocol ListenerProtocol {
    func onLog(level: Int, time: String, msg: String)
}


class Listener: ListenerProtocol {
    var event: Event

    init(event: Event) {
        self.event = event
    }

    func onLog(level: Int, time: String, msg: String) {
        event.onServerLog(level: Int64(level), time: time, log: msg) { result in
            switch result {
            case .success:
                print("日志已成功上报")
            case .failure(let error):
                print("上报失败: \(error)")
            }
        }
    }
}
