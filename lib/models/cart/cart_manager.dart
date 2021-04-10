import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/models/user/address.dart';
import 'package:loja_virtual/models/user/user.dart';
import 'package:loja_virtual/models/user/user_manager.dart';


import 'package:loja_virtual/services/cepaberto_service.dart';

import '../cart/cart_product.dart';



class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];

  User user;
  Address address;

  num productPrice = 0.0;
  num deliveryPrice;

  num get totalPrice => productPrice + (deliveryPrice ?? 0);

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final Firestore firestore = Firestore.instance;

  void updateUser(UserManager userManager) {
    user = userManager.user;
    productPrice = 0.0;
    items.clear();
    removeAddress();

    if (user != null) {
      _loadCartItems();
      _loadUserAddress();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartReference.getDocuments();

    items = cartSnap.documents
        .map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpadted))
        .toList();
  }

  Future<void> _loadUserAddress() async {
    if (user.address != null &&
        await calculateDelivery(
            user.address.latitude, user.address.longitude)) {
      address = user.address;
      notifyListeners();
    }
  }

  void addToCart(Product product) {
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpadted);
      items.add(cartProduct);
      user.cartReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.documentID);
      _onItemUpadted();
    }
    notifyListeners();
  }

  void removeOfCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    user.cartReference.document(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpadted);
    notifyListeners();
  }

  void _onItemUpadted() {
    productPrice = 0.0;

    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];

      if (cartProduct.quantity == 0) {
        removeOfCart(cartProduct);

        i--;

        continue;
      }
      productPrice += cartProduct.totalPrice;

      _updateCartProduct(cartProduct);
    }

    notifyListeners();
  }

  void _updateCartProduct(CartProduct cartProduct) {
    if (cartProduct.id != null)
      user.cartReference
          .document(cartProduct.id)
          .updateData(cartProduct.toCartItemMap());
  }

  // Verificando o carrinho
  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) return false;
    }
    return true;
  }

  bool get isAddressValid => address != null && deliveryPrice != null;

  //ADDRESS

  Future<void> getAddress(String cep) async {
    loading = true;

    final cepAbertoService = CepAbertoService();

    try {
      final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);

      if (cepAbertoAddress != null) {
        address = Address(
            street: cepAbertoAddress.logradouro,
            district: cepAbertoAddress.bairro,
            zipCode: cepAbertoAddress.cep,
            city: cepAbertoAddress.cidade.nome,
            state: cepAbertoAddress.estado.sigla,
            latitude: cepAbertoAddress.latitude,
            longitude: cepAbertoAddress.longitude);
      }
      loading = false;
    } catch (e) {
      loading = false;
      return Future.error('CEP Invalido');
    }
  }

  void removeAddress() {
    address = null;
    deliveryPrice = null;
    notifyListeners();
  }

  Future<void> setAddress(Address address) async {
    loading = true;

    this.address = address;

    if (await calculateDelivery(address.latitude, address.longitude)) {
      user.setAddress(address);
      loading = false;
    } else {
      loading = false;
      return Future.error('Endereco fora do raio de entrega :(');
    }
  }

  Future<bool> calculateDelivery(double latitude, double longitude) async {
    final DocumentSnapshot doc = await firestore.document('aux/delivery').get();

    final latStore = doc.data['latitude'] as double;

    final lonStore = doc.data['longitude'] as double;

    final maxkm = doc.data['maxkm'] as num;

    final base = doc.data['base'] as num;

    final km = doc.data['km'] as num;

    double dis = await Geolocator()
        .distanceBetween(latStore, lonStore, latitude, longitude);

    dis /= 1000.0;

    debugPrint('Distancia $dis');

    if (dis > maxkm) {
      return false;
    }

    deliveryPrice = base + dis * km;
    return true;
  }

//Apagar items no carrinho
  void clear() {
    for (final cartProduct in items) {
      user.cartReference.document(cartProduct.id).delete();
    }
    items.clear();
    notifyListeners();
  }
}
