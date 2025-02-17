import 'package:flutter/material.dart';
import 'package:logo_search/extensions/colors_extension.dart';
import 'package:logo_search/extensions/image_extension.dart';
import 'package:logo_search/models/brand_search_response.dart';

class SearchLogoTableRow extends StatefulWidget {
  final LogoInfo logoInfo;

  const SearchLogoTableRow({super.key, required this.logoInfo});

  @override
  State<SearchLogoTableRow> createState() => _SearchLogoTableRowState();
}

class _SearchLogoTableRowState extends State<SearchLogoTableRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        children: [
          // Logo
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.logoInfo.imageUrl ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand Name
              Text(
                widget.logoInfo.name ?? '',
                style: TextStyle(
                  color: CustomColors.text.primary,
                  fontSize: 16.0,
                ),
              ),
              // Brand Domain
              Text(
                widget.logoInfo.domain ?? '',
                style: const TextStyle(
                  color: CustomColors.lightGray,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.center, // 讓 Container 在 Row 內上下置中
            child: Container(
              child: Images.table.row.detail,
            ),
          ),
        ],
      ),
    );
  }
}
