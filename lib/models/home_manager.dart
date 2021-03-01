import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/section.dart';

class HomeManager extends ChangeNotifier {
  HomeManager() {
    _loadSections();
  }

  List<Section> _sections = [];

  List<Section> _edittingections = [];

  bool editing = false;

  final Firestore firestore = Firestore.instance;

  Future<void> _loadSections() async {
    firestore.collection('home').snapshots().listen((snapshot) {
      _sections.clear();
      for (final DocumentSnapshot document in snapshot.documents) {
        _sections.add(Section.fromDocument(document));
      }
      notifyListeners();
    });
  }

  void removeSection(Section section) {
    _edittingections.remove(section);
    notifyListeners();
  }

  void addSection(Section section) {
    _edittingections.add(section);
    notifyListeners();
  }

  List<Section> get sections {
    if (editing)
      return _edittingections;
    else
      return _sections;
  }

  void enterEditing() {
    editing = true;

    _edittingections = _sections.map((s) => s.clone()).toList();

    notifyListeners();
  }

  void saveEditing() {
    editing = false;
    notifyListeners();
  }

  void discardEditing() {
    editing = false;
    notifyListeners();
  }
}
