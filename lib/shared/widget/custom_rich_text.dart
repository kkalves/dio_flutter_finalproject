import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String title;
  final String text;
  const CustomRichText({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      overflow: TextOverflow.ellipsis,
      maxLines: 15,
      TextSpan(
        text: title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary),
        children: [
          TextSpan(
              text: text,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary)),
        ],
      ),
    );
  }
}
