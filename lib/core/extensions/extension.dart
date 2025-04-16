import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../screens/calling_screen/loading_wrapper_screen.dart';
import '../providers/firebase_provider.dart';

export 'context_extension.dart';
export 'date_extension.dart';
export 'num_extension.dart';
export 'string_extension.dart';
export 'ui_ext.dart';

extension RefExtension on Ref {
  void loading(bool isLoading) {
    read(loadingProvider.notifier).update((state) => isLoading);
  }

  FirebaseFirestore firestore() => read(firestoreProvider);
}
