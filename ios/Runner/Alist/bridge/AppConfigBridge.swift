//
//  AppConfigBridge.swift
//  Runner
//
//  Created by apple on 2024/8/15.
//

import Foundation
import Alistlib

class AppConfigBridge: AppConfig {
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
        let greeting = UserDefaults.standard.string(forKey: "DataDir")
        if (greeting != nil){
            return greeting!
        } else {
            let documentsDirectory = NSHomeDirectory().appending("/Documents")
            return documentsDirectory
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
