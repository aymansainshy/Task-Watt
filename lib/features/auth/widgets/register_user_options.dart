import 'package:flutter/material.dart';
import 'package:task_watt/core/constant.dart';

class RegisterOptions extends StatefulWidget {
  const RegisterOptions({
    super.key,
    required this.mediaQuery,
  });

  final Size mediaQuery;

  @override
  State<RegisterOptions> createState() => _RegisterOptionsState();
}

class _RegisterOptionsState extends State<RegisterOptions> {
  final userOptions = ['Student', 'Teacher'];

  var selectedOptions = 3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: SizedBox(
        height: kElevatedButtonHeight,
        // color: Colors.grey,
        width: widget.mediaQuery.width,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                2,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOptions = index;
                    });
                  },
                  child: Container(
                    width: constraints.maxWidth * 0.48,
                    height: constraints.maxHeight,
                    decoration: BoxDecoration(
                      color: selectedOptions == index ? const Color(0xFFD7FCDA) : Colors.yellow,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                      border: selectedOptions == index
                          ? Border.all(color: Colors.yellow, width: 2)
                          : Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(
                        userOptions[index],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
