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
              child: Text(
                '象限 ${index + 1}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }),
    );
  }
}
