import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:library_ui/globals.dart';
import 'package:sizer/sizer.dart';

enum StageType { done, ongoing, upcoming }

class OngoingStageWidget extends StatelessWidget {
  const OngoingStageWidget({super.key, required this.stageType, required this.stageName});
  final StageType stageType;
  final String stageName;
  @override
  Widget build(BuildContext context) {
    if (stageType == StageType.done) {
      return Container(
        decoration: BoxDecoration(
          color: MyColors.brown,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
      );
    }else if(stageType == StageType.ongoing){
      return MovingGradientLoader(loadingText: "Waiting to be $stageName");
    }else{
      return Container(
        decoration: BoxDecoration(
          color: MyColors.brown.withOpacity(.2),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
      );
      }
  }
}

class MovingGradientLoader extends StatefulWidget {
  final String loadingText;
  const MovingGradientLoader({
    Key? key,
    required this.loadingText,
  }) : super(key: key);

  @override
  _MovingGradientLoaderState createState() => _MovingGradientLoaderState();
}

class _MovingGradientLoaderState extends State<MovingGradientLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // int i = 1;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // if(_controller.value > .98 || _controller.value < .02){
        //   i = -i;
        // }
        return Container(
          margin: EdgeInsets.all(10),
          // width: widget.width,
          // height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.2),
            //     blurRadius: 8,
            //     offset: const Offset(0, 4),
            //   ),
            // ],
            gradient: LinearGradient(
              colors: [
                MyColors.brown,
                MyColors.brown.withOpacity(.8),
                MyColors.brown,
              ],
              // Animate the gradient by changing the begin and end points
              begin: Alignment((-1.5 + 2 * _controller.value), 0),
              end: Alignment((-.5 + 2 * _controller.value), 0),
            ),
          ),
          child: Center(
            child: _buildLoader(),
          ),
        );
      },
    );
  }

  Widget _buildLoader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.loadingText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: const Offset(1, 1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                ...List.generate(
                  3,
                  (index) {
                    final delay = index / 3;
                    final opacityValue = ((_controller.value + delay) % 1.0);
                    final sizeValue = math.sin(opacityValue * math.pi);

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: .3.w,
                      height: .3.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5 + sizeValue * 0.5),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            blurRadius: 8 * sizeValue,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
