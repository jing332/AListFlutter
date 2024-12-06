//
//  AppConfigBridge.swift
//  Runner
//
//  Created by apple on 2024/8/15.
//

import Foundation
import Alistlib

/**
 * Alist 一些参数配置, 这些应该在 Flutter 实现
 */
class AppConfigBridge:NSObject, AppConfig {
    
    static var instance = AppConfigBridge()
    
    private override init() {}

    func isWakeLockEnabled() throws -> Bool {
        let retVal = UserDefaults.standard.bool(forKey: "WakeLockEnabled")
        if(retVal){
            return retVal
        } else {
            return false
        }
    }

    func isStartAtBootEnabled() throws -> Bool {
        let retVal = UserDefaults.standard.bool(forKey: "StartAtBootEnabled")
        if(retVal){
            return retVal
        } else {
            return false
        }
    }

    func isAutoCheckUpdateEnabled() throws -> Bool {
        let retVal = UserDefaults.standard.bool(forKey: "AutoCheckUpdateEnabled")
        if(retVal){
            return retVal
        } else {
            return false
        }
    }

    func isAutoOpenWebPageEnabled() throws -> Bool {
        let retVal = UserDefaults.standard.bool(forKey: "AutoOpenWebPageEnabled")
        if(retVal){
            return retVal
        } else {
            return false
        }
    }

    func getDataDir() throws -> String {
        let dataDir = UserDefaults.standard.string(forKey: "DataDir")
        if (dataDir != nil && !dataDir!.isEmpty){
            return dataDir!
        } else {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            return documentsDirectory.path
        }
    }

    func setDataDir(dir: String) throws {
        UserDefaults.standard.set(dir, forKey: "DataDir")
    }

    func isSilentJumpAppEnabled() throws -> Bool {
        let retVal = UserDefaults.standard.bool(forKey: "SilentJumpAppEnabled")
        if(retVal){
            return retVal
        } else {
            return false
        }
    }

    func setSilentJumpAppEnabled(enabled: Bool) throws {
        UserDefaults.standard.set(enabled, forKey: "SilentJumpAppEnabled")
    }

    func setAutoOpenWebPageEnabled(enabled: Bool) throws {
        UserDefaults.standard.set(enabled, forKey: "AutoOpenWebPageEnabled")
    }

    func setAutoCheckUpdateEnabled(enabled: Bool) throws {
        UserDefaults.standard.set(enabled, forKey: "AutoCheckUpdateEnabled")
    }

    func setStartAtBootEnabled(enabled: Bool) throws {
        UserDefaults.standard.set(enabled, forKey: "StartAtBootEnabled")
    }

    func setWakeLockEnabled(enabled: Bool) throws {
        UserDefaults.standard.set(enabled, forKey: "WakeLockEnabled")
    }
}
