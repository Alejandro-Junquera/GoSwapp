import 'package:flutter/material.dart';

import '../../providers/providers.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarPersonalizado extends StatelessWidget {
  const BottomNavigationBarPersonalizado({super.key});

  @override
  Widget build(BuildContext context) {
    final profProvider = Provider.of<ProfProvider>(context);
    final currentIndex = profProvider.selectedMenuOpt;
    return BottomNavigationBar(
      onTap: (int i) => profProvider.selectedMenuOpt = i,
      elevation: 0,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.done), label: '')
      ],
    );
  }
}
