//
//  CommonBridge.swift
//  Runner
//
//  Created by apple on 2024/8/15.
//

import Foundation
import Alistlib

class CommonBridge: NativeCommon {

    /**
     * 从 URL 启动第三方应用
     */
    func startActivityFromUri(intentUri: String) throws -> Bool {
        guard let url = URL(string: intentUri) else {
            print("Invalid URL")
            return false
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Cannot open URL: \(intentUri)")
            return false
        }
        return true
    }

    func getDeviceSdkInt() throws -> Int64 {
        return 33
    }

    func getDeviceCPUABI() throws -> String {
#if arch(arm)
        if #available(iOS 13.0, *) {
            return "arm64"
        } else {
            return "armv7"
        }
#elseif arch(x86_64)
        return "x86_64"
#else
        return "unknown"
#endif
    }

    func getVersionName() throws -> String {
        // return "22.33.4444"
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "22.33.44443333"
        }
        return version
    }

    func getVersionCode() throws -> Int64 {
        // return 44
        guard let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {
         return Int64(44)
        }
        return Int64(version) ?? Int64(0)
    }

    func toast(msg: String) throws {
        CommonBridge.showToast(message: msg)
    }

    func longToast(msg: String) throws {
        CommonBridge.showToast(message: msg,duration: 3)
    }
    
    static func showToast(message: String, duration: TimeInterval = 2.0) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.font = .systemFont(ofSize: 14.0)
        toastLabel.textColor = .white
        toastLabel.numberOfLines = 0
        // toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.backgroundColor = .clear
        toastLabel.layer.cornerRadius = 5.0
        toastLabel.clipsToBounds = true
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
     
        let toastContainer = UIView()
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.addSubview(toastLabel)
        
        toastContainer.layer.cornerRadius = 5.0
        toastLabel.clipsToBounds = true
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
     
        NSLayoutConstraint.activate([
            toastLabel.topAnchor.constraint(equalTo: toastContainer.topAnchor, constant: 8.0),
            toastLabel.leadingAnchor.constraint(equalTo: toastContainer.leadingAnchor, constant: 20.0),
            toastLabel.trailingAnchor.constraint(equalTo: toastContainer.trailingAnchor, constant: -20.0),
            toastLabel.bottomAnchor.constraint(equalTo: toastContainer.bottomAnchor, constant: -8.0)
        ])
     
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(toastContainer)
     
            NSLayoutConstraint.activate([
                toastContainer.centerXAnchor.constraint(equalTo: window.centerXAnchor),
                toastContainer.centerYAnchor.constraint(equalTo: window.centerYAnchor),
                toastContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 280.0),
            ])
     
            UIView.animate(withDuration: 1, delay: 3.0, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.1
            }, completion: { _ in
                toastContainer.removeFromSuperview()
            })
        }
    }
}
