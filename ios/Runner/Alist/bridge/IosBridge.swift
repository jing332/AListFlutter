//
//  IosBridge.swift
//  Runner
//
//  Created by apple on 2024/8/15.
//

import Foundation
import Alistlib

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
            AList.instance.startup()
            isRuning = true
        } else {
            AList.instance.shutdown()
            isRuning = false
        }
        
        event.onServiceStatusChanged(isRunning: isRuning){ result in
            switch result {
            case .success:
                print("状态日志已成功上报")
            case .failure(let error):
                print("状态上报失败: \(error)")
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
        return AList.instance.isRunning()
    }

    func getAListVersion() throws -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
              return version
            } else {
              return "ios"
            }
    }
}
