import 'package:flutter/material.dart';

class HomeListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Widget leading;
  const HomeListTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Center(
        child: ListTile(
          dense: false,
          contentPadding: const EdgeInsets.all(5),
          onTap: onTap,
          title: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.primary,
            child: leading,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              title,
              textScaleFactor: 1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
      ),
    );
  }
}
