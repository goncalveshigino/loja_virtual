import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/home/section.dart';

class HomeManager extends ChangeNotifier {
  HomeManager() {
    _loadSections();
  }

  final List<Section> _sections = [];

  List<Section> _edittingections = [];

  bool editing = false;
  bool loading = false;

  final Firestore firestore = Firestore.instance;

  Future<void> _loadSections() async {
    firestore.collection('home').orderBy('pos').snapshots().listen((snapshot) {
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

  Future<void> saveEditing() async {
    bool valid = true;

    for (final section in _edittingections) {
      if (!section.valid()) valid = false;
    }

    if (!valid) return;

    loading = true;
    notifyListeners();

    int pos = 0;
    for (final section in _edittingections) {
      await section.save(pos);
      pos++;
    }

    for (final section in List.from(_sections)) {
      if (!_edittingections.any((element) => element.id == section.id)) {
        await section.delete();
      }
    }

    loading = false;
    editing = false;
    notifyListeners();
  }

  void discardEditing() {
    editing = false;
    notifyListeners();
  }
}
