//
//  AList.swift
//  Runner
//
//  Created by apple on 2024/8/15.
//

import Foundation
import Alistlib

/*这里是与go语言交互的逻辑代码*/
class AList: NSObject, AlistlibEventProtocol, AlistlibLogCallbackProtocol {

    static var instance = AList()

    private override init() {}

    func dataDir() -> String {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.path
    }

    func initAlist() {
        Alistlib.AlistlibSetConfigDebug(true)
        Alistlib.AlistlibSetConfigData(dataDir())
        Alistlib.AlistlibSetConfigLogStd(true)
        var error: NSError?
        Alistlib.AlistlibInit(self, self, &error)
        if (error == nil) {
              NSLog("ok")
            } else {
                NSLog("server start 服务启动失败")
            }
    }

    func onProcessExit(_ code: Int) {

    }


    func onStartError(_ t: String?, err: String?) {
        Logger.instance.log(level: LogLevel.FATAL, time: t ?? "", msg: err ?? "")
    }

    func onLog(_ level: Int16, time: Int64, message: String?) {
        // MM-dd HH:mm:ss
        Logger.instance.log(level: Int(level), time: "09-23 12:33:33", msg: message ?? "")
    }

    func isRunning() -> Bool {
        return Alistlib.AlistlibIsRunning("")
    }

    func setAdminPassword(pwd: String) {
        if (!isRunning()) {
            // init()
            self.initAlist()
        }
        Alistlib.AlistlibSetConfigData(dataDir())
        Alistlib.AlistlibSetAdminPassword(pwd)
    }


    func shutdown() {
        do {
            Alistlib.AlistlibShutdown(5000, nil)
        } catch let err{
            NSLog("停止异常")
        }
    }

    func startup() {
        // init()
        self.initAlist()
        Alistlib.AlistlibStart()
    }

    func getHttpPort() -> Int {
        return 5244
    }

    var listeners = [ShutdownListenerProtocol]()

    func addListener(listener: ShutdownListenerProtocol) {
        listeners.append(listener)
    }

    func removeListener(listener: ShutdownListenerProtocol) {

    }

    func onShutdown(_ t: String?) {
        listeners.forEach { element in
            element.onShutdown(type: t ?? "")
        }
    }
}

public protocol ShutdownListenerProtocol {
    func onShutdown(type: String)
}

class ShutdownListener: ShutdownListenerProtocol {
    var event: Event

    init(event: Event) {
        self.event = event
    }

    func onShutdown(type: String) {
        // todo 这里要写逻辑代码
    }
}
