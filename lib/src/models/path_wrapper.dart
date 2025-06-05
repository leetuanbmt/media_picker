import 'dart:typed_data' as typed_data;

import 'package:flutter/foundation.dart';

@immutable
class PathWrapper<Path> {
  const PathWrapper({required this.path, this.assetCount, this.thumbnailData});

  final Path path;

  final int? assetCount;

  final typed_data.Uint8List? thumbnailData;

  PathWrapper<Path> copyWith({
    int? assetCount,
    typed_data.Uint8List? thumbnailData,
  }) {
    return PathWrapper<Path>(
      path: path,
      assetCount: assetCount ?? this.assetCount,
      thumbnailData: thumbnailData ?? this.thumbnailData,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is PathWrapper<Path> &&
        other.path == path &&
        other.assetCount == assetCount &&
        other.thumbnailData == thumbnailData;
  }

  @override
  int get hashCode =>
      path.hashCode ^ assetCount.hashCode ^ thumbnailData.hashCode;

  @override
  String toString() {
    return '$runtimeType('
        'path: $path, '
        'assetCount: $assetCount, '
        'thumbnailData: ${thumbnailData?.runtimeType}'
        ')';
  }
}
