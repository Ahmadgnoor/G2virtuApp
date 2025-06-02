import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:orderit/util/enums.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ConnectivityService {
  StreamController<ConnectivityStatus> connectivityStatusController =
      StreamController<ConnectivityStatus>.broadcast();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> status) {
      connectivityStatusController.add(getStatusFromResult(status));
    });
  }

  ConnectivityStatus getStatusFromResult(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.wifi)) {
      return ConnectivityStatus.wifi;
    } else if (results.contains(ConnectivityResult.mobile)) {
      return ConnectivityStatus.cellular;
    } else if (results.contains(ConnectivityResult.none)) {
      return ConnectivityStatus.offline;
    } else {
      return ConnectivityStatus.offline;
    }
  }
}

// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:orderit/util/enums.dart';
// import 'package:injectable/injectable.dart';

// @lazySingleton
// class ConnectivityService {
//   StreamController<ConnectivityStatus> connectivityStatusController =
//       StreamController<ConnectivityStatus>.broadcast();

//   ConnectivityService() {
//     Connectivity().onConnectivityChanged.listen((status) {
//       connectivityStatusController.add(getStatusFromResult(status));
//     });
//   }

//   ConnectivityStatus getStatusFromResult(ConnectivityResult result) {
//     switch (result) {
//       case ConnectivityResult.wifi:
//         return ConnectivityStatus.wifi;
//       case ConnectivityResult.mobile:
//         return ConnectivityStatus.cellular;
//       case ConnectivityResult.none:
//         return ConnectivityStatus.offline;
//       default:
//         return ConnectivityStatus.offline;
//     }
//   }
// }
