//
//  CommonBridge.swift
//  Runner
//
//  Created by apple on 2024/8/15.
//

import Foundation
import Alistlib

class CommonBridge: NativeCommon {

    func startActivityFromUri(intentUri: String) throws -> Bool {
        return true
    }

    func getDeviceSdkInt() throws -> Int64 {
        return 33
    }

    func getDeviceCPUABI() throws -> String {
        return ""
    }

    func getVersionName() throws -> String {
        return "22.33.4444"
    }

    func getVersionCode() throws -> Int64 {
        return 44
    }

    func toast(msg: String) throws {

    }

    func longToast(msg: String) throws {

    }
}
