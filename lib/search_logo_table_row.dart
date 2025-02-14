import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // Logo
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.logoInfo.imageUrl ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          // Brand Name
          Text(
            widget.logoInfo.name ?? '',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
