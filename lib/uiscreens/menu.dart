import 'package:firebasestorage/models/cart_model.dart';
import 'package:firebasestorage/models/menu_model.dart';
import 'package:firebasestorage/uiscreens/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  final String restaurantId;
  final String restaurantName;

  const MenuScreen({super.key, required this.restaurantId, required this.restaurantName});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late MenuModel menuModel;

  @override
  void initState() {
    super.initState();
    menuModel = MenuModel(restaurantId: widget.restaurantId);
    _loadMenu();
  }

  Future<void> _loadMenu() async {
    await menuModel.fetchMenu();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurantName),
        backgroundColor: Colors.red,
        actions: [

         IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); 
          }),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: menuModel.length,
        itemBuilder: (context, index) => _MyListItem(index, menuModel),
      ),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;
  final MenuModel menu;

  const _MyListItem(this.index, this.menu);

  @override
  Widget build(BuildContext context) {
    var item = menu.getByPosition(index);
    var textTheme = Theme.of(context).textTheme.titleLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            const Icon(Icons.fastfood),
            const SizedBox(width: 24),
            Expanded(child: Text(item.name, style: textTheme)),
            Text('Rs ${item.price}'),
            const SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({required this.item});

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<CartModel, bool>(
      (cart) => cart.items.containsKey(item),
    );

    return TextButton(
      onPressed: isInCart
          ? null
          : () {
              var cart = context.read<CartModel>();
              cart.add(item);
            },
      child: isInCart
          ? const Icon(Icons.check, semanticLabel: "ADDED")
          : const Text("ADD"),
    );
  }
}
