import UIKit
import flutter_inappwebview_ios
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    override func application(_ application: UIApplication,
                              didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        let controller = window?.rootViewController as! FlutterViewController
        let binaryMessage = controller.binaryMessenger
        let event = Event.init(binaryMessenger: binaryMessage)
        
        AppConfigSetup.setUp(binaryMessenger: binaryMessage, api: AppConfigBridge.instance)
        AndroidSetup.setUp(binaryMessenger: binaryMessage, api: IosBridge.init(event: event))
        NativeCommonSetup.setUp(binaryMessenger: binaryMessage, api: CommonBridge())

        Logger.instance.addListener(listener: Listener.init(event: event))

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
