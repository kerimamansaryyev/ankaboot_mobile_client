import 'package:flutter/cupertino.dart';

final class PersistentSliverHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  PersistentSliverHeader({
    required this.child,
    required this.height,
  });

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) =>
      child;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
