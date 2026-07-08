import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _SearchDialog extends StatelessWidget {
  const _SearchDialog();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [

          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 18,
              sigmaY: 18,
            ),
            child: Container(
              color: Colors.black12,
            ),
          ),

          Center(
            child: Container(
              width: 420,
              constraints: const BoxConstraints(
                maxHeight: 600,
              ),
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surface,
                borderRadius:
                BorderRadius.circular(32),
              ),
              child: const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}