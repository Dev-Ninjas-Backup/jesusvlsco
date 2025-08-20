import 'package:flutter/material.dart';

class ApiCustomButtonContainer extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String text;
  final Color? bgcolor;
  final double? width;
  final IconData? icon;

  const ApiCustomButtonContainer({
    super.key,
    required this.text,
    this.bgcolor,
    this.width,
    this.icon,
    this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left column with title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                if (subTitle != null)
                  Text(
                    subTitle!,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
              ],
            ),
          ),

          SizedBox(width: 16),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: width ?? 140,
              height: 45,
              decoration: BoxDecoration(
                color: bgcolor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) Icon(icon, color: Colors.white),
                    if (icon != null) SizedBox(width: 8.0),
                    Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
