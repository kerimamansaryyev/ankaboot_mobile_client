import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  final String text;

  const EmptyListWidget({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
