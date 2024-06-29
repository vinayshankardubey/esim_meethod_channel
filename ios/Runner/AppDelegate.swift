import UIKit
import Flutter
import CoreTelephony

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let esimChannel = FlutterMethodChannel(name: "com.example.esim/install",
                                           binaryMessenger: controller.binaryMessenger)
    esimChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "installEsim" {
        guard let args = call.arguments as? [String: Any],
              let lpaUrl = args["lpaUrl"] as? String else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument", details: nil))
          return
        }
        self.installEsim(lpaUrl: lpaUrl, result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func installEsim(lpaUrl: String, result: @escaping FlutterResult) {
    let esimManager = CTCellularPlanProvisioning()
    let eSimDetails = CTCellularPlanProvisioningRequest()
    eSimDetails.address = lpaUrl

    esimManager.addPlan(with: eSimDetails) { (resultCode) in
      switch resultCode {
      case .unknown:
        result(FlutterError(code: "ERROR", message: "Unknown error", details: nil))
      case .fail:
        result(FlutterError(code: "ERROR", message: "Failed to add eSIM plan", details: nil))
      case .success:
        result("eSIM installed successfully")
      @unknown default:
        result(FlutterError(code: "ERROR", message: "Unknown error", details: nil))
      }
    }
  }
}
