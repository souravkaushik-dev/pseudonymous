import 'dart:async';

import '../model/username_models.dart';
import '../repository/username_repository.dart';

class UsernameController {
  Timer? _debounce;

  UsernameStatus status = UsernameStatus.initial;

  Future<UsernameStatus> checkUsername(
      String username,
      ) async {
    _debounce?.cancel();

    if (username.length < 4) {
      return UsernameStatus.invalid;
    }

    final completer = Completer<UsernameStatus>();

    _debounce = Timer(
      const Duration(milliseconds: 500),
          () async {
        final available =
        await UsernameRepository.isUsernameAvailable(
          username,
        );

        completer.complete(
          available
              ? UsernameStatus.available
              : UsernameStatus.taken,
        );
      },
    );

    return completer.future;
  }

  void dispose() {
    _debounce?.cancel();
  }
}