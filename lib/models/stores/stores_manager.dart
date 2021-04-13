import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/stores/store.dart';

class StoresManager extends ChangeNotifier {
  StoresManager() {
    _loadStoreList();
  }

  List<Store> stores = [];

  Timer _timer;

  final Firestore firestore = Firestore.instance;

  Future<void> _loadStoreList() async {
    final snapshot = await firestore.collection('stores').getDocuments();

    stores = snapshot.documents.map((e) => Store.fromDocument(e)).toList();

    notifyListeners();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkOpeninh();
    });
  }

  void _checkOpeninh() {
    for (final store in stores) store.updateStatus();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
