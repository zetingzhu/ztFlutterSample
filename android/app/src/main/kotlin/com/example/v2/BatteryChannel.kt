package com.example.v2

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * @author: zeting
 * @date: 2025/9/2
 *
 */
class BatteryChannel(flutterEngine: BinaryMessenger, context: Context) :
    MethodChannel.MethodCallHandler {
    private val batteryChannelName = "cn.blogss/battery"
    private var channel: MethodChannel
    private var mContext: Context

    companion object {
        private const val TAG = "BatteryChannel"
    }

    init {
        channel = MethodChannel(flutterEngine, batteryChannelName)
        channel.setMethodCallHandler(this)
        mContext = context;
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.d(TAG, "onMethodCall: " + call.method)
        if (call.method == "getBatteryLevel") {
            val batteryLevel = getBatteryLevel()
            if (batteryLevel != -1) {
                result.success(batteryLevel)
            } else {
                result.error("UNAVAILABLE", "Battery level not available.", null)
            }
        } else {
            result.notImplemented()
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager =
                mContext.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(mContext).registerReceiver(
                null,
                IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            )
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) *
                    100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }
}