import 'package:flutter/material.dart';

class SubscribeBtn extends StatelessWidget {
  const SubscribeBtn({super.key});

  // 这个组件是当前页面的根组件。
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SubscribeButton(
          viewModel: SubscribeButtonViewModel(
            subscriptionRepository: SubscriptionRepository(),
          ),
        ),
      ),
    );
  }
}

/// 模拟订阅操作的按钮组件。
/// 例如：订阅新闻简报或流媒体频道。
class SubscribeButton extends StatefulWidget {
  const SubscribeButton({super.key, required this.viewModel});

  /// 订阅按钮的视图模型 (ViewModel)。
  final SubscribeButtonViewModel viewModel;

  @override
  State<SubscribeButton> createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<SubscribeButton> {
  @override
  void initState() {
    super.initState();
    // 监听 ViewModel 的状态变化
    widget.viewModel.addListener(_onViewModelChange);
  }

  @override
  void dispose() {
    // 组件销毁时移除监听
    widget.viewModel.removeListener(_onViewModelChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        return FilledButton(
          onPressed: widget.viewModel.subscribe,
          style: widget.viewModel.subscribed
              ? SubscribeButtonStyle.subscribed
              : SubscribeButtonStyle.unsubscribed,
          child: widget.viewModel.subscribed
              ? const Text('已订阅')
              : const Text('订阅'),
        );
      },
    );
  }

  /// 响应 ViewModel 状态变化的回调。
  void _onViewModelChange() {
    // 如果订阅操作失败
    if (widget.viewModel.error) {
      // 重置错误状态
      widget.viewModel.error = false;
      // 显示错误提示消息
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('订阅失败')));
    }
  }
}

class SubscribeButtonStyle {
  static const unsubscribed = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.red),
  );

  static const subscribed = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.green),
  );
}

/// 订阅按钮的视图模型。
/// 负责处理订阅逻辑并向 UI 暴露状态。
class SubscribeButtonViewModel extends ChangeNotifier {
  SubscribeButtonViewModel({required this.subscriptionRepository});

  final SubscriptionRepository subscriptionRepository;

  // 用户是否已订阅
  bool subscribed = false;

  // 订阅操作是否失败
  bool error = false;

  // 订阅操作逻辑
  Future<void> subscribe() async {
    // 如果已经订阅，则忽略点击
    if (subscribed) {
      return;
    }

    // 乐观更新：先假设订阅成功更新 UI。
    // 如果后续请求失败，会进行状态回滚。
    subscribed = true;
    // 通知监听器以更新 UI 状态
    notifyListeners();

    try {
      await subscriptionRepository.subscribe();
    } catch (e) {
      print('订阅失败: $e');
      // 发生错误，回退到未订阅状态
      subscribed = false;
      // 设置错误状态以触发 UI 提示
      error = true;
    } finally {
      // 最终无论成功失败都通知一次 UI
      notifyListeners();
    }
  }
}

/// 订阅仓库类，负责数据层逻辑。
class SubscriptionRepository {
  /// 模拟网络请求，设定为必定失败。
  Future<void> subscribe() async {
    // 模拟网络延迟
    await Future.delayed(const Duration(seconds: 1));
    // 一秒后抛出异常模拟失败
    throw Exception('Failed to subscribe');
  }
}
