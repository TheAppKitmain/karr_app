import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/utils/Constants.dart';

class CustomStepper extends StatelessWidget {
  final int steps;
  final int currentStep;

  CustomStepper({required this.steps, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(steps, (index) {
        final isActive = index == currentStep;
        final isCompleted = index < currentStep;

        return Expanded(
          child:
          Padding(
            padding: const EdgeInsets.all(12.0),

            child: Container(
              height: 8.0,

              decoration: BoxDecoration(
                color: isActive ? Colors.black : isCompleted ? AppColors.primaryColor : Colors.black,

                  borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
            ),
          ),
        );
      }),
    );
  }
}