import 'package:flutter/material.dart';
import '../../../constants/sizes.dart';

class SliverSample extends StatefulWidget {
  const SliverSample({super.key});

  @override
  State<SliverSample> createState() => _SliverSampleState();
}

class _SliverSampleState extends State<SliverSample> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          // floating: true,
          stretch: true,
          pinned: true,
          // floating: true,
          // snap: true,
          backgroundColor: Colors.teal,
          centerTitle: true,
          collapsedHeight: 80,
          expandedHeight: 300,
          title: const Text("Outer Title"),
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.blurBackground,
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
            titlePadding: EdgeInsets.zero,
            background: Image.asset(
              "assets/images/image_0001.png",
              fit: BoxFit.cover,
            ),
            title: const Text("Inner Title"),
            centerTitle: true,
          ),
        ),
        const SliverToBoxAdapter(
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.red,
                child: Text("aaa"),
                radius: 25,
              )
            ],
          ),
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                color: Colors.amber[100 * (index % 9)],
                child: Center(
                  child: Text("Item $index"),
                ),
              );
            },
            childCount: 20,
          ),
          itemExtent: 100,
        ),
        SliverPersistentHeader(
          delegate: CustomDelegate(),
          pinned: true,
          // floating: true,
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                color: Colors.blue[100 * (index % 9)],
                child: Center(
                  child: Text("Item $index"),
                ),
              );
            },
            childCount: 20,
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            mainAxisSpacing: Sizes.size20,
            crossAxisSpacing: Sizes.size20,
            childAspectRatio: 1,
          ),
        ),
      ],
    );
  }
}

class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.indigo,
      child: const FractionallySizedBox(
        heightFactor: 1,
        child: Center(
          child: Text(
            "Grid Area",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
