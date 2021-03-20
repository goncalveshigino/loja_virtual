import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/cart_product.dart';
import 'package:loja_virtual/models/order.dart';
import 'package:loja_virtual/models/product.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;

  final Firestore firestore = Firestore.instance;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // ignore: use_setters_to_change_properties
  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }

  Future<void> checkout({Function onStockFail, Function onSuccess}) async {
      
      loading = true;

    try {
      await _decrementStock();
    } catch (e) {
      onStockFail(e);
      loading = false;
      return;
    }

    // TODO: PROCESSAR PAGAMENTO

    final orderId = await _getOrderId();

    final order = Order.fromCartManager(cartManager);
    order.orderId = orderId.toString();

    await order.save();

    cartManager.clear();

    onSuccess();

     loading = false;
  }

  Future<int> _getOrderId() async {
    final ref = firestore.document('aux/ordercounter');

    try {
      final result = await firestore.runTransaction((tx) async {
        final doc = await tx.get(ref);
        final orderId = doc.data['current'] as int;
        await tx.update(ref, {'current': orderId + 1});
        return {'orderId': orderId};
      });
      return result['orderId'] as int;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error('Falha ao gerar número do pedido');
    }
  }

  Future<void> _decrementStock() {
    return firestore.runTransaction((tx) async {
      final List<Product> productsToUpdate = [];
      final List<Product> productsWithoutStock = [];

      for (final cartProduct in cartManager.items) {
        Product product;

        if (productsToUpdate.any((p) => p.id == cartProduct.productId)) {
          product =
              productsToUpdate.firstWhere((p) => p.id == cartProduct.productId);
        } else {
          final doc = await tx
              .get(firestore.document('products/${cartProduct.productId}'));
          product = Product.fromDocument(doc);
        }

        cartProduct.product = product;

        final size = product.findSize(cartProduct.size);

        if (size.stock - cartProduct.quantity < 0) {
          productsWithoutStock.add(product);
        } else {
          size.stock -= cartProduct.quantity;
          productsToUpdate.add(product);
        }
      }

      if (productsWithoutStock.isNotEmpty) {
        return Future.error(
            '${productsWithoutStock.length} Produtos sem estoque');
      }

      for (final product in productsToUpdate) {
        tx.update(firestore.document('products/${product.id}'),
            {'sizes': product.exportSizeList()});
      }
    });
  }
}
