import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomScrollViewV2 extends StatelessWidget {
  const CustomScrollViewV2({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Floating Navigation Bar';
    return CupertinoPageScaffold(
      // No navigation bar provided to CupertinoPageScaffold,
      // only a body with a CustomScrollView.
      child: CustomScrollView(
        slivers: [
          // Add the navigation bar to the CustomScrollView.
          const CupertinoSliverNavigationBar(
            // Provide a standard title.
            largeTitle: Text(title),
          ),
          // Next, create a SliverList
          SliverList.builder(
            // The builder function returns a CupertinoListTile with a title
            // that displays the index of the current item.
            itemBuilder: (context, index) =>
                CupertinoListTile(title: Text('Item #$index')),
            // Builds 50 CupertinoListTile
            itemCount: 50,
          ),
        ],
      ),
    );
  }
}
