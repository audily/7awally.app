import 'package:flutter/material.dart';

class WillPopWidget extends StatelessWidget {
  const WillPopWidget({super.key, required this.child, required this.canPop, required this.onPopMethod});

  final Widget child;
  final bool canPop;
  final VoidCallback onPopMethod;

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: canPop,
        onPopInvokedWithResult: (didPop, value){
          if (didPop) {
            Navigator.pop(context);
            return;
          }else{
            onPopMethod();
          }
        },
        child: child
    );
  }
}
