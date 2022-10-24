import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/order_model.dart';

class OrderTile extends StatefulWidget {
  final Order order;
  const OrderTile({
    super.key,
    required this.order,
  });

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  Future<String> getStatus() async {
    var result = await FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.order.id)
        .get();
    final res = result.get("status");
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center();
        }
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "Status: ${snapshot.data}",
                  textScaleFactor: 1,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: snapshot.data == "Pending"
                            ? Theme.of(context).colorScheme.primary
                            : snapshot.data == "Out for Delivery"
                                ? Colors.green
                                : Theme.of(context).colorScheme.secondary,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "Items",
                  textScaleFactor: 1,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    List itemName = widget.order.items.keys.toList();
                    List itemQuantity = widget.order.items.values.toList();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          itemName[index],
                          textScaleFactor: 1,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        Text(
                          itemQuantity[index],
                          textScaleFactor: 1,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ],
                    );
                  },
                  itemCount: widget.order.items.keys.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
