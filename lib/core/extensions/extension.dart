import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/global_provider.dart';

export 'context_extension.dart';
export 'date_extension.dart';
export 'num_extension.dart';
export 'string_extension.dart';

extension RefExtension on Ref {
  void loading(bool isLoading) {
    read(loadingProvider.notifier).update((state) => isLoading);
  }
}
