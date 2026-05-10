import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class VisibilityNotifier extends Notifier<Map<String, bool>> {
  @override
  Map<String, bool> build() {
    return {};
  }

  void setVisible(String sectionKey, bool value) {
    state = {...state, sectionKey: value};
  }
}

final visibilityProvider =
    NotifierProvider<VisibilityNotifier, Map<String, bool>>(() {
      return VisibilityNotifier();
    });

final activeSectionProvider = StateProvider<int>((ref) => 0);
