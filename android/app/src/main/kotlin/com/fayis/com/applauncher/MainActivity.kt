package com.fayis.com.applauncher


import android.app.role.RoleManager
import android.content.Intent
import android.os.Bundle
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivityLaunchConfigs.BackgroundMode.transparent
import android.content.Context
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraManager
import androidx.annotation.NonNull


class MainActivity : FlutterActivity() {
    private val CHANNEL = "launcher_channel"
    private var isFlashlightOn = false


    override fun onCreate(savedInstanceState: Bundle?) {
        intent.putExtra("background_mode", transparent.toString())

        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "launcher/flash").setMethodCallHandler { call, result ->
            if (call.method == "toggleFlash") {
                toggleFlash()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "launcher/launcher_popup").setMethodCallHandler { call, result ->
            if (call.method == "launcher_popup") {
                showLauncherSelection()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }


    //    fun registerFlashlightState(context: Context) {
//        cameraManager.registerTorchCallback(torchCallback, null)
//    }
//
//    fun unregisterFlashlightState(context: Context) {
//        cameraManager.unregisterTorchCallback(torchCallback)
//    }
//
//    private val torchCallback = object : CameraManager.TorchCallback() {
//        override fun onTorchModeChanged(cameraId: @NonNull String, enabled: Boolean) {
//            super.onTorchModeChanged(cameraId, enabled)
//            isFlashlightOn = enabled
//        }
//    }
    private fun showLauncherSelection() {
        val roleManager = getSystemService(Context.ROLE_SERVICE)
                as RoleManager
        if (roleManager.isRoleAvailable(RoleManager.ROLE_HOME) &&
                !roleManager.isRoleHeld(RoleManager.ROLE_HOME)
        ) {
            val intent = roleManager.createRequestRoleIntent(RoleManager.ROLE_HOME)
            startActivity(intent)
        }
    }

    private fun toggleFlash() {
        val cameraManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
        try {
            val cameraId = cameraManager.cameraIdList[0]
            isFlashlightOn = !isFlashlightOn
            cameraManager.setTorchMode(cameraId, isFlashlightOn)
        } catch (e: CameraAccessException) {
            e.printStackTrace()
        }

    }

    private fun showLauncherDialog() {
        val intent = Intent(Settings.ACTION_HOME_SETTINGS)
        startActivity(intent)
    }
}


