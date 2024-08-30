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

    /**
     * 获取配置文件路径
     */
    func dataDir() -> String {
        do {
            // 读取配置文件的路径
            let result = try AppConfigBridge.instance.getDataDir()
            return result
        } catch {
            // 如果没有则返回默认路径
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            return documentsDirectory.path
        }
    }

    /**
     * 初始化 Alist 服务
     */
    func initAlist() {
        // Alistlib.AlistlibSetConfigDebug(true)
        Alistlib.AlistlibSetConfigData(dataDir())
        Alistlib.AlistlibSetConfigLogStd(true)
        var error: NSError?
        Alistlib.AlistlibInit(self, self, &error)
        if (error == nil) {
            NSLog("ok")
        } else {
            NSLog("server start 服务启动失败")
            let now = CFAbsoluteTimeGetCurrent()
            onLog(Int16(LogLevel.ERROR), time: Int64(now), message: "服务启动失败")
        }
    }

    func onProcessExit(_ code: Int) {

    }

    func onStartError(_ t: String?, err: String?) {
        Logger.instance.log(level: LogLevel.FATAL, time: t ?? "", msg: err ?? "")
    }
    
    func onShutdown(_ t: String?) {
        listeners.forEach { element in
            element.onShutdown(type: t ?? "")
        }
    }

    /**
     * 是否正在运行
     */
    func isRunning() -> Bool {
        return Alistlib.AlistlibIsRunning("http")
    }

    /**
     * 设置 Alist 管理员密码
     */
    func setAdminPassword(pwd: String) {
        if (!isRunning()) {
            print("notRunning")
            self.initAlist()
        }else{
            print("isRunning")
        }
        Alistlib.AlistlibSetConfigData(dataDir())
        Alistlib.AlistlibSetAdminPassword(pwd)
    }

    /**
     * 关闭 Alist
     */
    func shutdown() {
        var error: NSError?
        Alistlib.AlistlibShutdown(5000, &error)
        if (error == nil) {
            NSLog("ok")
        } else {
            NSLog("server start 服务关闭失败")
            let now = CFAbsoluteTimeGetCurrent()
            onLog(Int16(LogLevel.ERROR), time: Int64(now), message: "服务关闭失败")
        }
    }

    /**
     * 启动 Alist
     */
    func startup() {
        // init()
        self.initAlist()
        let dataChangeCallbackHandler = AlistlibDataChangeCallback()
        Alistlib.AlistlibStart(dataChangeCallbackHandler)
    }

    /**
     * 获取 Alist 端口号
     */
    func getHttpPort() -> Int {
        return 5244
    }
    
    /**
     *  打印日志, 这个日志会在日志列表展示
     *  @param level LogLevel.xxx
     *  @param time let now = CFAbsoluteTimeGetCurrent()
     */
    func onLog(_ level: Int16, time: Int64, message: String?) {
        // MM-dd HH:mm:ss
        let date = Date(timeIntervalSince1970: Double(time))

        // 创建 DateFormatter 实例
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd HH:mm:ss"
        
        // 格式化日期
        let formattedDate = dateFormatter.string(from: date)

        Logger.instance.log(level: Int(level), time: formattedDate, msg: message ?? "")
    }
    
    // Alist 关闭事件的监听和处理
    var listeners = [ShutdownListenerProtocol]()

    func addListener(listener: ShutdownListenerProtocol) {
        listeners.append(listener)
    }

    func removeListener(listener: ShutdownListenerProtocol) {

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
