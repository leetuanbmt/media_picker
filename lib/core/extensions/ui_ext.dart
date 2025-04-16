import 'package:flutter/material.dart';

extension ErrorUIExt on BuildContext {
  Widget buildError(Object error, StackTrace? stackTrace) {
    return Center(
      child: Text(error.toString()),
    );
  }

  Widget buildEmptyList(String message) {
    return Center(
      child: Text(
        message,
        style: Theme.of(this).textTheme.titleMedium?.copyWith(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
      ),
    );
  }
}
