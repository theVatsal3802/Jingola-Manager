import 'package:flutter/material.dart';

import '../functions/other_functions.dart';

class MenuListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Widget leading;
  final String id;
  final bool instock;
  const MenuListTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.leading,
    required this.id,
    required this.instock,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(title),
      onDismissed: (direction) async {
        await OtherFunctions.deleteMenuItem(
          id,
          context,
        );
      },
      background: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Icon(
            Icons.delete,
            color: Colors.red,
          )
        ],
      ),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Confirm your action",
                textScaleFactor: 1,
                style: Theme.of(context).textTheme.headline4,
              ),
              content: Text(
                "Are you sure you want to permanently delete $title?",
                textScaleFactor: 1,
                style: Theme.of(context).textTheme.headline5,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text(
                    "NO",
                    textScaleFactor: 1,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    "YES",
                    textScaleFactor: 1,
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
            width: 1,
          ),
        ),
        child: ListTile(
          dense: false,
          contentPadding: const EdgeInsets.all(5),
          onTap: onTap,
          leading: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.primary,
            child: leading,
          ),
          title: Text(
            title,
            textScaleFactor: 1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
          trailing: Tooltip(
            message: instock ? "Mark as Not in Stock" : "Mark as In Stock",
            child: IconButton(
              onPressed: () async {
                instock
                    ? await OtherFunctions.markOutOfStock(
                        id,
                        context,
                      )
                    : await OtherFunctions.markInStock(
                        id,
                        context,
                      );
              },
              icon: Icon(
                instock ? Icons.close : Icons.check,
                color: instock ? Colors.red : Colors.green,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
