package com.example.v3

import android.content.Context
import com.example.v4.ComputeLayoutPlatformFactory
import com.example.v4.ComputeLayoutPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin

/**
 * @author: zeting
 * @date: 2025/9/2
 *
 */
class ZztUIPlugin(var rootContext: Context) : FlutterPlugin {
    companion object {
        // Android原生View 在Flutter引擎上注册的唯一标识，在Flutter端使用时必须一样
        const val viewType: String = "com.example.v3.channel.viewType"
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        binding.platformViewRegistry.registerViewFactory(
            viewType,
            ZztViewFactory(rootContext, binding.binaryMessenger)
        )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {

    }
}