import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String title;
  final String text;
  const CustomRichText({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Text.rich(
      TextSpan(
        text: title,
        style: themeData.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold, color: themeData.colorScheme.primary),
        children: [
          TextSpan(
              text: text,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: themeData.colorScheme.primary)),
        ],
      ),
    );
  }
}
