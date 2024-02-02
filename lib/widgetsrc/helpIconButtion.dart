import 'package:flutter/material.dart';

class HelpIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const HelpIconButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
        onPressed: onPressed,
        icon: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: const Icon(
            Icons.help,
            color: Colors.white,
          ),
        ),
        tooltip: '도움말',
      ),
    );
  }
}
