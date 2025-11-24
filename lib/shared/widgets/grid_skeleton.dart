import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GridSkeleton extends StatelessWidget {
  final SliverGridDelegateWithFixedCrossAxisCount? gridDelegate;
  final bool isTile;

  const GridSkeleton({
    super.key,
    this.gridDelegate,
    this.isTile = false,
    required int columns,
    required double gap,
    required int count,
  });
  // double _calculateAspectRatio(double height) {
  //   if (height <= 670) return 0.65;
  //   if (height <= 820) return 0.7;
  //   if (height <= 900) return 0.75;
  //   return 0.8;
  // }

  @override
  Widget build(BuildContext context) {
    // final double screenHeight = MediaQuery.of(context).size.height;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 25,
        crossAxisSpacing: 25,
        childAspectRatio: 1,
      ),
      itemCount: 4,
      itemBuilder: (_, i) => const CardSkeleton(
          // o: () => onCategoryTap?.call(visible[i]),
          ),
    );
  }
}

class CardSkeleton extends StatelessWidget {
  const CardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            width: 2,
            color: Theme.of(context).dividerColor,
          ),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  height: 16,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
