import 'package:flutter/foundation.dart' show ChangeNotifier;

enum Status { loading, success, error }

class StatusViewModel with ChangeNotifier {
  Status _status = Status.loading;

  Status get status => _status;

  set status(Status status) {
    _status = status;
    notifyListeners();
  }

  bool isLoading() => _status == Status.loading;
  bool isSuccess() => _status == Status.success;
  bool isError() => _status == Status.error;
}
