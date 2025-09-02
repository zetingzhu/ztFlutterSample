package com.example.zt_flutter_sample_v2

import androidx.appcompat.app.AppCompatActivity
import com.example.v1.CustomAndroidViewFactory
import com.example.v2.BatteryChannel
import com.example.v3.ZztUIPlugin
import com.example.v4.ComputeLayoutPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterFragmentActivity() {
    companion object {
        private const val TAG = "MainActivity"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        BatteryChannel(flutterEngine.dartExecutor.binaryMessenger, baseContext)  // 实例化通道

        val customViewFactory = CustomAndroidViewFactory(
            flutterEngine.dartExecutor.binaryMessenger, baseContext
        )

        // 注册 Platform View Factory
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("android_custom_view", customViewFactory)

        // 注册为Flutter插件
        flutterEngine.plugins.add(ComputeLayoutPlugin(this))

        // 注册自己写的插件
        flutterEngine.plugins.add(ZztUIPlugin(this))
    }
}