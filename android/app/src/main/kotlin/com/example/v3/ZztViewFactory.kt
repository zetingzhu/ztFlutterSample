package com.example.v3

import android.content.Context
import com.example.v4.ComputeLayoutPlatform
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/**
 * @author: zeting
 * @date: 2025/9/2
 *
 */
class ZztViewFactory(
    private val rootContext: Context,
    private val messenger: BinaryMessenger, // 二进制信使
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(
        context: Context,
        viewId: Int,
        args: Any?
    ): PlatformView {
        return ZztView(context, rootContext, messenger, viewId, args)
    }

}