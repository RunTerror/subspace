import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InternetState { connected, disconnected, initial }

class InternetCubit extends Cubit<InternetState> {
  final _connectivity = Connectivity();
  StreamSubscription? _streamSubscription;
  InternetCubit() : super(InternetState.disconnected){

  _streamSubscription=  _connectivity.onConnectivityChanged.listen((event) { 
      if(event == ConnectivityResult.mobile || event==ConnectivityResult.wifi || event==ConnectivityResult.ethernet){
        emit(InternetState.connected);
      }
      else{
        emit(InternetState.disconnected);
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
