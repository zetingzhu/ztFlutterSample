package com.example.v1

import android.content.Context
import android.graphics.Color
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import android.widget.Button
import android.widget.EditText
import android.widget.LinearLayout
import android.widget.TextView
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.common.MethodChannel.Result

class CustomAndroidView(
    private val context: Context,
    id: Int,
    creationParams: Map<String?, Any?>?,
    private val methodChannel: MethodChannel
) : PlatformView, MethodChannel.MethodCallHandler {

    private val linearLayout: LinearLayout = LinearLayout(context)
    private val titleTextView: TextView = TextView(context)
    private val editText: EditText = EditText(context)
    private val button: Button = Button(context)
    private val statusTextView: TextView = TextView(context)

    init {
        setupView(context, creationParams)
    }

    private fun setupView(context: Context, creationParams: Map<String?, Any?>?) {
        // 设置布局
        linearLayout.orientation = LinearLayout.VERTICAL
        linearLayout.setPadding(32, 32, 32, 32)

        // 从创建参数中获取配置
        val title = creationParams?.get("title") as? String ?: "Android UI"
        val backgroundColor = creationParams?.get("backgroundColor") as? Int ?: Color.GREEN

        linearLayout.setBackgroundColor(backgroundColor)

        // 标题
        titleTextView.text = title
        titleTextView.textSize = 20f
        titleTextView.setTextColor(Color.WHITE)
        titleTextView.setPadding(0, 0, 0, 24)

        // 输入框
        editText.hint = "在这里输入文本..."
        editText.setBackgroundColor(Color.WHITE)
        editText.setPadding(16, 16, 16, 16)
        editText.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {}
            override fun afterTextChanged(s: Editable?) {
                // 向 Flutter 发送文本变化事件
                methodChannel.invokeMethod("onTextChanged", s.toString())
            }
        })

        // 按钮
        button.text = "点击我"
        button.setBackgroundColor(Color.BLUE)
        button.setTextColor(Color.WHITE)
        button.setPadding(32, 16, 32, 16)
        button.setOnClickListener {
            val data = mapOf(
                "buttonText" to button.text.toString(),
                "inputText" to editText.text.toString(),
                "clickTime" to System.currentTimeMillis()
            )
            // 向 Flutter 发送按钮点击事件
            methodChannel.invokeMethod("onButtonClicked", data)

            // 更新状态文本
            statusTextView.text = "按钮被点击了！时间: ${System.currentTimeMillis()}"
        }

        // 状态文本
        statusTextView.text = "等待交互..."
        statusTextView.setTextColor(Color.WHITE)
        statusTextView.setPadding(0, 24, 0, 0)

        // 添加所有视图到布局
        linearLayout.addView(titleTextView)
        linearLayout.addView(editText)

        val buttonParams = LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT, LinearLayout.LayoutParams.WRAP_CONTENT
        )
        buttonParams.topMargin = 24
        linearLayout.addView(button, buttonParams)

        linearLayout.addView(statusTextView)
    }

    override fun getView(): View {
        return linearLayout
    }

    override fun dispose() {
        // 清理资源
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "updateTitle" -> {
                val newTitle = call.argument<String>("title") ?: "默认标题"
                titleTextView.text = newTitle
                result.success("标题已更新为: $newTitle")
            }
            "updateButtonText" -> {
                val newButtonText = call.argument<String>("buttonText") ?: "默认按钮"
                button.text = newButtonText
                result.success("按钮文本已更新为: $newButtonText")
            }
            "getInputText" -> {
                result.success(editText.text.toString())
            }
            "setInputText" -> {
                val text = call.argument<String>("text") ?: ""
                editText.setText(text)
                result.success("输入框文本已设置为: $text")
            }
            "updateStatus" -> {
                val status = call.argument<String>("status") ?: "状态未知"
                statusTextView.text = status
                result.success("状态已更新为: $status")
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    // 处理来自 Flutter 的数据
    fun handleFlutterData(data: Map<String, Any>) {
        val message = data["message"] as? String ?: ""
        val timestamp = data["timestamp"] as? Long ?: 0

        statusTextView.text = "收到 Flutter 数据: $message (时间戳: $timestamp)"
    }
}