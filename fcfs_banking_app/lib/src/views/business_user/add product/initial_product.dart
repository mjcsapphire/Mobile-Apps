import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});
  final List<Map<String, dynamic>> items = [
    {
      'name': 'Coca Cola',
      'price': 1.20,
      'image': 'assets/images/can.png',
      'quantity': 0
    },
    {
      'name': 'Ting',
      'price': 2.40,
      'image': 'assets/images/can.png',
      'quantity': 2
    },
    {
      'name': 'Fanta',
      'price': 1.20,
      'image': 'assets/images/can.png',
      'quantity': 0
    },
    {
      'name': 'Sprite',
      'price': 1.20,
      'image': 'assets/images/can.png',
      'quantity': 0
    },
    {
      'name': 'Tiger Malt',
      'price': 1.70,
      'image': 'assets/images/can.png',
      'quantity': 0
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkStackContainerColor1,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search item',
                hintStyle: const TextStyle(fontSize: 14),
                filled: true,
                fillColor: Colors.grey.shade800,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.pinkAccent],
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: const Text(
                'Beverages',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppColors.darkBgColor3,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white60),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      child: Card(
                        color: Colors.transparent,
                        child: ListTile(
                          leading: Image.asset(item['image'], width: 50),
                          title: Text(
                            item['name'],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          subtitle: Text(
                            '\$${item['price'].toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 16),
                          ),
                          trailing: item['quantity'] > 0
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('x${item['quantity']}',
                                        style: const TextStyle(
                                            color: Colors.purple,
                                            fontSize: 16)),
                                    const SizedBox(width: 10),
                                    const Text('Edit',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 16)),
                                  ],
                                )
                              : const Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$2.40',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Next',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
