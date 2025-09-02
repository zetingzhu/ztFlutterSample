package com.example.v1

import android.content.Context
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class CustomAndroidViewFactory(
    flutterEngine: BinaryMessenger,
    context: Context
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    private val CHANNEL = "com.example.android_ui_channel"
    private var methodChannel: MethodChannel
    private var currentView: CustomAndroidView? = null

    companion object {
        const val TAG = "ViewFactory"
    }

    init {
        methodChannel = MethodChannel(flutterEngine, CHANNEL)
    }

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as? Map<String?, Any?>
        currentView = CustomAndroidView(context, viewId, creationParams, methodChannel)
        return currentView!!
    }


}