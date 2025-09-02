package com.example.v3

import android.content.Context
import android.text.Editable
import android.text.TextWatcher
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.widget.FrameLayout
import com.example.zt_flutter_sample_v2.databinding.ZztViewLayoutBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import java.util.Objects

class ZztView(
    context: Context,
    rootContext: Context,
    messenger: BinaryMessenger,
    viewId: Int,
    args: Any?,
) : FrameLayout(context), PlatformView, MethodChannel.MethodCallHandler {
    var mChannel: MethodChannel? = null
    var binding: ZztViewLayoutBinding? = null

    // flutter 记录数据
    var curNumFlutter: Int = 11

    // android 记录数据
    var curNumAndroid: Int = 22

    companion object {
        val TAG = "flutter-ZztView"

        // 通道名称，Android端和Flutter端的，相互通信的通道，两端必须一致
        const val mChannelName: String = "com.example.v3.channel"

        // Flutter端 向 Android端 发送数据
        const val FLUTTER_TO_ANDROID: String = "flutterToAndroid";

        // Flutter端 获取 Android端 数据
        const val FLUTTER_GET_ANDROID: String = "flutterGetAndroid";

        // Android端 向 Flutter端 发送数据
        const val ANDROID_TO_FLUTTER: String = "androidToFlutter";

        // Android端 获取 Flutter端 数据
        const val ANDROID_GET_FLUTTER: String = "androidGetFlutter";
    }

    init {
        initChannel(messenger, viewId)
        initView()
        initData(rootContext, args)
    }

    private fun initData(rootContext: Context, args: Any?) {

    }

    private fun initView() {
        binding = ZztViewLayoutBinding.inflate(LayoutInflater.from(context), this, true)
        binding?.add?.setOnClickListener {
            curNumAndroid += 1
            binding?.tvCount?.setText("点击次数:" + curNumAndroid)
        }

        binding?.androidSendFlutterData?.setOnClickListener {
            androidSendFlutterData()
        }

        binding?.androidGetFlutterData?.setOnClickListener {
            androidGetFlutterData()
        }

        binding?.edInput?.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(
                s: CharSequence?,
                start: Int,
                count: Int,
                after: Int
            ) {

            }

            override fun onTextChanged(
                s: CharSequence?,
                start: Int,
                before: Int,
                count: Int
            ) {
            }

            override fun afterTextChanged(s: Editable?) {
                val input = s.toString()
                androidSendFlutterData(input)
            }
        })
    }

    /**
     * Android端 向 Flutter端 发送数据，PUT 操作
     */
    private fun androidSendFlutterData(input: String = "") {
        val map: MutableMap<String, Any> = mutableMapOf<String, Any>()
        map["androidNum"] = curNumAndroid
        map.put("inputStr", input)

        mChannel?.invokeMethod(
            ANDROID_TO_FLUTTER, map, object : MethodChannel.Result {
                override fun success(result: Any?) {
                    Log.d(TAG, "${ANDROID_TO_FLUTTER} success：$result")
                    binding?.tvCount?.setText("点击次数:" + curNumAndroid)
                }

                override fun error(
                    errorCode: String, errorMessage: String?, errorDetails: Any?
                ) {
                    Log.d(
                        TAG,
                        "${ANDROID_TO_FLUTTER} errorCode：$errorCode --- errorMessage：$errorMessage --- errorDetails：$errorDetails"
                    )
                }

                /**
                 * Flutter端 未实现 Android端 定义的接口方法
                 */
                override fun notImplemented() {
                    Log.d(TAG, "${ANDROID_TO_FLUTTER} Flutter端 未实现 Android端 定义的接口方法")
                }
            })
    }

    /**
     * Android端 获取 Flutter端 数据，GET 操作
     */
    private fun androidGetFlutterData() {
        mChannel?.invokeMethod(
            ANDROID_GET_FLUTTER, null, object : MethodChannel.Result {
                override fun success(result: Any?) {
                    Log.d(TAG, "${ANDROID_GET_FLUTTER} success：$result")
                    binding?.tvGetCount?.setText("获取Flutter页面点击次数:" + result)
                }

                override fun error(
                    errorCode: String, errorMessage: String?, errorDetails: Any?
                ) {
                    Log.d(
                        TAG,
                        "${ANDROID_GET_FLUTTER} errorCode：$errorCode --- errorMessage：$errorMessage --- errorDetails：$errorDetails"
                    )
                }

                /**
                 * Flutter端 未实现 Android端 定义的接口方法
                 */
                override fun notImplemented() {
                    Log.d(TAG, "${ANDROID_GET_FLUTTER} Flutter端 未实现 Android端 定义的接口方法")
                }
            })
    }

    private fun initChannel(messenger: BinaryMessenger, viewId: Int) {
        mChannel = MethodChannel(messenger, "$mChannelName/${viewId}")
        mChannel?.setMethodCallHandler(this)
    }

    /**
     * 监听来自 Flutter端 的消息通道
     *
     * call： Android端 接收到 Flutter端 发来的 数据对象
     * result：Android端 给 Flutter端 执行回调的接口对象
     */
    override fun onMethodCall(
        call: MethodCall, result: MethodChannel.Result
    ) {
        // 获取调用函数的名称
        val methodName: String = call.method
        val arguments = call.arguments
        when (methodName) {
            FLUTTER_TO_ANDROID -> {
                // 回调结果对象
                // 获取Flutter端传过来的数据
                val flutterCount: Int? = call.argument<Int>("flutterNum")
                Log.d(
                    TAG,
                    "$FLUTTER_TO_ANDROID + flutterCount：$flutterCount arguments：${arguments}"
                )

                curNumFlutter = flutterCount ?: 0
                binding?.tvSaveCount?.setText("接收Flutter端发送的点击次数:" + curNumFlutter)
                result.success("${FLUTTER_TO_ANDROID} success")
            }

            FLUTTER_GET_ANDROID -> {
                result.success(curNumAndroid)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun getView(): View? {
        return this
    }

    override fun dispose() {
    }

}
