import 'package:flutter/material.dart';

import 'net/UserService.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final UserService _userService = UserService();
  String _statusMessage = '点击按钮获取用户信息';

  Future<void> _fetchAndDisplayUser() async {
    setState(() {
      _statusMessage = '加载中...';
    });

    final response = await _userService.fetchUser(1);

    if (response.code == 0) {
      // 假设 0 代表成功
      final user = response.data;
      if (user != null) {
        setState(() {
          _statusMessage = '用户信息：\nID: ${user.id}\n姓名: ${user.name}';
        });
      } else {
        setState(() {
          _statusMessage = '未找到用户数据';
        });
      }
    } else {
      setState(() {
        _statusMessage = '请求失败：${response.message}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('用户资料')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _fetchAndDisplayUser,
              child: const Text('获取用户'),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _statusMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
