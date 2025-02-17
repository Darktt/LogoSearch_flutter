import 'package:flutter/material.dart';
import 'package:logo_search/extensions/colors_extension.dart';
import 'package:logo_search/extensions/image_extension.dart';
import 'package:logo_search/models/brand_search_response.dart';

typedef SearchLogoTableRowCallback = void Function(LogoInfo logoInfo);

class SearchLogoTableRow extends StatefulWidget {
  final LogoInfo logoInfo;
  final SearchLogoTableRowCallback? onDetailPressed;

  const SearchLogoTableRow(
      {super.key, required this.logoInfo, this.onDetailPressed});

  @override
  State<SearchLogoTableRow> createState() => _SearchLogoTableRowState();
}

class _SearchLogoTableRowState extends State<SearchLogoTableRow> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      title: Row(
        children: [
          _setupLogoImage(),
          const SizedBox(width: 15.0),
          Expanded(flex: 5, child: _setupNameAndDomain()),
          Expanded(flex: 0, child: SizedBox.shrink()),
          Align(
            alignment: Alignment.center, // 讓 Container 在 Row 內上下置中
            child: Container(
              child: Images.table.row.detail,
            ),
          ),
        ],
      ),
      onTap: () => widget.onDetailPressed?.call(widget.logoInfo),
    );
  }

  Widget _setupLogoImage() {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.logoInfo.imageUrl ?? ''),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _setupNameAndDomain() {
    final name = widget.logoInfo.name ?? '';
    final domain = widget.logoInfo.domain ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand Name
        Text(
          name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            color: CustomColors.text.primary,
            fontSize: 16.0,
          ),
        ),
        // Brand Domain
        Text(
          domain,
          style: TextStyle(
            color: CustomColors.text.secondary,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
