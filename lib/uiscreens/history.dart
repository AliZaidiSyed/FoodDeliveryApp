
import 'package:firebasestorage/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory  ({super.key});

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();

    return Scaffold(
      appBar: AppBar(
       leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); 
          }),
        title: const Text('Order History'),
        backgroundColor: Colors.red,
      ),
      body:SingleChildScrollView(
        scrollDirection:Axis.vertical,
      
      
        
       
        child: Table(
          border: TableBorder.all(),
          defaultColumnWidth: FixedColumnWidth(120.0),
          children: [
            
            
            TableRow(
              decoration:  BoxDecoration(color: Colors.grey),
              children:[
                
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            ...cart.items.entries.map((entry) {
              var item = entry.key;
              var qty = entry.value;
              var total = (item.price * qty);
              var date = DateTime.now().toString().split(' ')[0];
              return TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(date),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.name),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('$qty'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('\$$total'),
                ),
              ]);
            }).toList(),
          ],
        ),
      ),
    );
  }
}
