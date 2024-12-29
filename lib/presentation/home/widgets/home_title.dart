import 'package:flutter/material.dart';
import 'package:seblak_sulthane_app/core/extensions/date_time_ext.dart';
import '../../../core/components/search_input.dart';
import '../../../core/constants/colors.dart';

class HomeTitle extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value)? onChanged;

  const HomeTitle({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate available width for search input
        final availableWidth = constraints.maxWidth;
        final titleWidth = availableWidth * 0.5; // 50% for title
        final searchWidth =
            availableWidth * 0.45; // 45% for search (leaving 5% margin)

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title and Date Section
            SizedBox(
              width: titleWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Seblak Sulthane',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 20, // Slightly reduced font size
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    DateTime.now().toFormattedDate(),
                    style: const TextStyle(
                      color: AppColors.subtitle,
                      fontSize: 14, // Slightly reduced font size
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Search Input Section
            SizedBox(
              width: searchWidth,
              child: SearchInput(
                controller: controller,
                onChanged: onChanged,
                hintText: 'Search..',
              ),
            ),
          ],
        );
      },
    );
  }
}
