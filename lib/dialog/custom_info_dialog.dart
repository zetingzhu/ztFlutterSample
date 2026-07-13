import 'package:flutter/material.dart';

import '../widgets/app_button.dart';

/// 弹框按钮监听，参数为弹框自身的 [BuildContext]。
typedef CustomInfoDialogListener = void Function(BuildContext dialogContext);

/// 自定义信息弹框配置。
class CustomInfoDialogOptions {
  const CustomInfoDialogOptions({
    this.imageAsset = 'imgs/ic_app_logo.png',
    this.title = '提示',
    this.content = '这是弹框内容',
    this.confirmText = '确定',
    this.cancelText = '取消',
    this.barrierDismissible = true,
    this.onConfirm,
    this.onCancel,
    this.onClose,
    this.onBarrierDismiss,
  });

  final String imageAsset;
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final bool barrierDismissible;

  /// 点击「确定」时触发，触发后会自动关闭弹框。
  final CustomInfoDialogListener? onConfirm;

  /// 点击「取消」时触发，触发后会自动关闭弹框。
  final CustomInfoDialogListener? onCancel;

  /// 点击右上角关闭按钮时触发，触发后会自动关闭弹框。
  final CustomInfoDialogListener? onClose;

  /// 点击遮罩关闭时触发；未设置时不会额外回调。
  final CustomInfoDialogListener? onBarrierDismiss;
}

/// 显示公用自定义信息弹框。
Future<void> showCustomInfoDialog(
  BuildContext context, {
  CustomInfoDialogOptions options = const CustomInfoDialogOptions(),
}) {
  var closedByAction = false;

  return showDialog<void>(
    context: context,
    barrierDismissible: options.barrierDismissible,
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 36),
        child: CustomInfoDialog(
          options: options,
          onDismiss: () {
            closedByAction = true;
            Navigator.of(dialogContext).pop();
          },
        ),
      );
    },
  ).then((_) {
    if (!closedByAction && context.mounted) {
      options.onBarrierDismiss?.call(context);
    }
  });
}

/// 公用自定义信息弹框组件。
class CustomInfoDialog extends StatelessWidget {
  const CustomInfoDialog({
    super.key,
    required this.options,
    required this.onDismiss,
  });

  final CustomInfoDialogOptions options;
  final VoidCallback onDismiss;

  static const double imageSize = 80;

  void _handleAction(BuildContext context, CustomInfoDialogListener? listener) {
    listener?.call(context);
    onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: imageSize / 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, imageSize / 2 + 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  options.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E1F23),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  options.content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Color(0xFF878E9C),
                  ),
                ),
                const SizedBox(height: 24),
                AppButton.submit(
                  text: options.confirmText,
                  fontSize: 16,
                  onPressed: () => _handleAction(context, options.onConfirm),
                ),
                const SizedBox(height: 8),
                AppButton.cancel(
                  text: options.cancelText,
                  onPressed: () => _handleAction(context, options.onCancel),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          // ClipOval：把子组件裁成圆形，图片才会显示成圆
          child: ClipOval(
            child: Image.asset(
              options.imageAsset,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover, // cover 铺满圆形区域
              errorBuilder: (_, __, ___) {
                return const ColoredBox(
                  color: Color(0xFFEAF2FF),
                  child: Icon(
                    Icons.card_giftcard,
                    size: 40,
                    color: Color(0xFF1676FE),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          top: imageSize / 2 + 4,
          right: 4,
          child: IconButton(
            onPressed: () => _handleAction(context, options.onClose),
            icon: const Icon(Icons.close, size: 20),
            color: const Color(0xFF878E9C),
            splashRadius: 20,
            tooltip: '关闭',
          ),
        ),
      ],
    );
  }
}
