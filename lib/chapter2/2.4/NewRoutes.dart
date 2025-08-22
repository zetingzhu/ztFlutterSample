import 'package:flutter/material.dart';

class NewRouter extends StatelessWidget {
  const NewRouter({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    print("获取路由参数：${args ?? 'null'}");

    return Scaffold(
      appBar: AppBar(title: const Text('命名路由跳转地方')),
      body: const Center(child: Text('命名路由跳转地方 arguments:')),
    );
  }
}
