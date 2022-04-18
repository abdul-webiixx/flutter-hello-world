import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/flutter_shimmer.dart';
import 'package:flutter/material.dart';

class Shimmer extends StatefulWidget {
  final ShimmerFor shimmerFor;
  const Shimmer({Key? key, required this.shimmerFor}) : super(key: key);
  @override
  _ShimmerState createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> {
  @override
  Widget build(BuildContext context) {
    return shimmerWidgets(widget.shimmerFor);
  }

  Widget shimmerWidgets(ShimmerFor shimmerFor) {
    switch (shimmerFor) {
      case ShimmerFor.InstructorHome:
        return Column(
          children: [
            profileShimmer(),
            BoxShimmer(
              hasCustomColors: true,
              colors: color(),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return ListVerticalShimmer(
                        height: 70,
                        hasCustomColors: true,
                        colors: color(),
                      );
                    }))
          ],
        );
      case ShimmerFor.CourseScreen:
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return ListBoxVerticalShimmer(
                      height: 150,
                    );
                  }),
            ),
          ],
        );
      case ShimmerFor.Choreography:
        return ListVerticalShimmer(
          height: 80,
          hasCustomColors: true,
          colors: color(),
        );
      case ShimmerFor.Home:
        return Scaffold(
          body: Column(
            children: [
              ListBoxVerticalShimmer(
                hasCustomColors: true,
                colors: color(),
                height: 140,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return ListVerticalShimmer(
                        height: 70,
                        hasCustomColors: true,
                        colors: color(),
                      );
                    }),
              )
            ],
          ),
        );
    }
  }

  Widget profileShimmer() {
    return ProfileShimmer(
      hasCustomColors: true,
      colors: color(),
    );
  }

  List<Color> color() {
    return [
      Color(0xFF474747),
      // light color
      Color(0xFF828282),
      // Medium color
      Color(0xFF424241)
    ];
  }
}
