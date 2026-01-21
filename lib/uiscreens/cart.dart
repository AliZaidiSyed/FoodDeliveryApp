import 'package:firebasestorage/models/cart_model.dart';
import 'package:firebasestorage/uiscreens/history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderHistory()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: _CartList(),
            ),
          ),
          Divider(height: 4, color: Colors.black),
          _CartTotal(),
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.titleLarge;
    var cart = context.watch<CartModel>();

    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) {
        var item = cart.items.keys.elementAt(index);
        var quantity = cart.items[item]!;

        return ListTile(
          leading: Icon(Icons.done),
          title: Text('${item.name} (\$${item.price})', style: itemNameStyle),
          trailing: Row(
        mainAxisSize:MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () {
                  cart.remove(item);
                },
              ),
              Text('$quantity'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  cart.add(item);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CartModel>(
              builder: (context, cart, child) => Text('\$${cart.totalPrice}'),
            ),
            const SizedBox(width: 24),
            FilledButton(
              onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder:(context)=> OrderHistory()));
              
              },
              child: Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}

