import 'package:flutter/material.dart';

class QuadrantGrid extends StatelessWidget {
  final Function(int) onTap;

  QuadrantGrid({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(4, (index) {
        return InkWell(
          onTap: () => onTap(index + 1),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.blue.shade200,
            ),
            child: Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: index == 0
                          ? '重要'
                          : index == 1
                              ? '重要'
                              : index == 2
                                  ? '紧急'
                                  : '不重要',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '\n',
                    ),
                    TextSpan(
                      text: index == 0
                          ? '且紧急'
                          : index == 1
                              ? '不紧急'
                              : index == 2
                                  ? '不重要'
                                  : '且紧急',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }),
    );
  }
}
