import 'package:flutter/material.dart';

class CustomScrollViewV1 extends StatelessWidget {
  const CustomScrollViewV1({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Floating App Bar';

    return Scaffold(
      // No app bar provided to Scaffold, only a body with a
      // CustomScrollView.
      body: CustomScrollView(
          slivers: [
            // Add the app bar to the CustomScrollView.
            const SliverAppBar(
              // Provide a standard title.
              title: Text(title),
              // Pin the app bar when scrolling
              pinned: true,
              // Display a placeholder widget to visualize the shrinking size.
              flexibleSpace: Placeholder(),
              // Make the initial height of the SliverAppBar larger than normal.
              expandedHeight: 200,
            ),
            // Next, create a SliverList
            SliverList.builder(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
              itemBuilder: (context, index) =>
                  ListTile(title: Text('Item #$index')),
              // Builds 50 ListTiles
              itemCount: 50,
            ),
          ],
        ),
      );
  }
}
