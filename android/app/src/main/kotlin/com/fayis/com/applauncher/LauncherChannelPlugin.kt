package com.fayis.com.applauncher

import android.content.Context
import android.content.Intent
import android.provider.Settings
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar

class LauncherChannelPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var context: Context
    private lateinit var channel: MethodChannel

    companion object {
        private const val CHANNEL_NAME = "launcher_channel"

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val plugin = LauncherChannelPlugin()
            plugin.setup(registrar.context(), registrar.messenger())
        }
    }

    private fun setup(context: Context, messenger: io.flutter.plugin.common.BinaryMessenger) {
        this.context = context
        channel = MethodChannel(messenger, CHANNEL_NAME)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "setDefaultLauncher" -> {
                setDefaultLauncher()
                result.success(null)
            }

            else -> result.notImplemented()
        }
    }

    private fun setDefaultLauncher() {
        val intent = Intent(Settings.ACTION_HOME_SETTINGS)
        context.startActivity(intent)
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        setup(flutterPluginBinding.applicationContext, flutterPluginBinding.binaryMessenger)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    }
}
