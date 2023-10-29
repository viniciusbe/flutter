import 'package:flutter/foundation.dart' show ChangeNotifier;

enum Status { loading, fetched, created, error }

class StatusViewModel with ChangeNotifier {
  Status _status = Status.loading;

  Status get status => _status;

  set status(Status status) {
    _status = status;
    notifyListeners();
  }

  bool isLoading() => _status == Status.loading;
  bool isFetched() => _status == Status.fetched;
  bool isCreated() => _status == Status.created;
  bool isError() => _status == Status.error;
}
