package com.example.esim

import android.os.Bundle
import android.telephony.euicc.EuiccManager
import android.telephony.euicc.DownloadableSubscription
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.esim/esim"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "installEsim") {
                val activationCode = call.argument<String>("activationCode")
                if (activationCode != null) {
                    installEsim(activationCode)
                    result.success("Success")
                } else {
                    result.error("INVALID_CODE", "Activation code is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun installEsim(activationCode: String) {
        val euiccManager = getSystemService(EuiccManager::class.java)
        val downloadableSubscription = DownloadableSubscription.forActivationCode(activationCode)
        val intentSender = null // This can be used to handle success/failure callbacks if needed

        euiccManager.downloadSubscription(downloadableSubscription, true, intentSender)
    }
}
