//
//  IosBridge.swift
//  Runner
//
//  Created by apple on 2024/8/15.
//

import Foundation
import Alistlib
import Combine

/**
 * 提供给 Flutter 调用的接口
 */
class IosBridge: Android {

    var event: Event

    init(event: Event) {
        self.event = event
    }
    
    var isRuning = false

    func addShortcut() throws {

    }

    func startService() throws {
        if (!isRuning) {
            isRuning = true
            AList.instance.startup()
            HCKeepBGRunManager.shared.startBGRun()
            NotificationManager.shared.scheduleNotification("AListServer", body: "服务正在运行中")
            CommonBridge.showToast(message: "启动中...")
        } else {
            isRuning = false
            AList.instance.shutdown()
            HCKeepBGRunManager.shared.stopBGRun()
            NotificationManager.shared.removeNotification()
        }
        
        // 延迟3秒上报启动状态
        //DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            if(AList.instance.isRunning()){
                print("Alist 运行中....")
            }else{
                print("Alist 未运行....")
            }
            self.event.onServiceStatusChanged(isRunning: self.isRuning){ result in
                switch result {
                case .success:
                    print("状态日志已成功上报")
                case .failure(let error):
                    print("状态上报失败: \(error)")
                }
            }
        }
    }

    func setAdminPwd(pwd: String) throws {
        AList.instance.setAdminPassword(pwd: pwd)
    }

    func getAListHttpPort() throws -> Int64 {
        return Int64(AList.instance.getHttpPort())
    }

    func isRunning() throws -> Bool {
        // return AList.instance.isRunning()
        return isRuning
    }

    func getAListVersion() throws -> String {
        return "v3.36.0"
    }
}
