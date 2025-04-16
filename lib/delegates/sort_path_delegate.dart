part of '../media_picker.dart';

abstract class SortPathDelegate<Path> {
  const SortPathDelegate();

  void sort(List<PathWrapper<Path>> list);

  static const SortPathDelegate<AssetPathEntity> common =
      CommonSortPathDelegate();
}

class CommonSortPathDelegate extends SortPathDelegate<AssetPathEntity> {
  const CommonSortPathDelegate();

  @override
  void sort(List<PathWrapper<AssetPathEntity>> list) {
    if (list.any(
      (PathWrapper<AssetPathEntity> e) => e.path.lastModified != null,
    )) {
      list.sort(
        (PathWrapper<AssetPathEntity> a, PathWrapper<AssetPathEntity> b) {
          if (a.path.lastModified == null || b.path.lastModified == null) {
            return 0;
          }
          if (b.path.lastModified!.isAfter(a.path.lastModified!)) {
            return 1;
          }
          return -1;
        },
      );
    }
    list.sort(
      (PathWrapper<AssetPathEntity> a, PathWrapper<AssetPathEntity> b) {
        if (a.path.isAll) {
          return -1;
        }
        if (b.path.isAll) {
          return 1;
        }
        if (_isCamera(a.path)) {
          return -1;
        }
        if (_isCamera(b.path)) {
          return 1;
        }
        if (_isScreenShot(a.path)) {
          return -1;
        }
        if (_isScreenShot(b.path)) {
          return 1;
        }
        return 0;
      },
    );
  }

  int otherSort(AssetPathEntity path1, AssetPathEntity path2) {
    return path1.name.compareTo(path2.name);
  }

  bool _isCamera(AssetPathEntity entity) {
    return entity.name == 'Camera';
  }

  bool _isScreenShot(AssetPathEntity entity) {
    return entity.name == 'Screenshots' || entity.name == 'Screenshot';
  }
}
