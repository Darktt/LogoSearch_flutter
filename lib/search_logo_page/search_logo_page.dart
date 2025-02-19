import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:logo_search/models/colors.dart';
import 'package:logo_search/models/brand_search_request.dart';
import 'package:logo_search/models/route.dart';
import 'package:logo_search/search_logo_page/search_logo_table_row.dart';
import 'package:logo_search/view_model/logo_search_action.dart';
import 'package:logo_search/view_model/logo_search_store.dart';

class SearchLogoPage extends StatefulWidget {
  // Properties

  const SearchLogoPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchLogoPageState createState() => _SearchLogoPageState();
}

// - _SearchLogoPageState -

class _SearchLogoPageState extends State<SearchLogoPage> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final store = context.watch<LogoSearchStore>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Logo Search'),
        centerTitle: true,
        backgroundColor: CustomColors.background,
        foregroundColor: CustomColors.foreground,
      ),
      body: Container(
        color: CustomColors.background,
        child: Padding(
          padding: EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SearchBar(
                onInputChanged: (value) => _searchText = value,
                onSearchPressed: () => _sendSearchAction(store),
              ),
              Expanded(child: _setupListView(store)),
            ],
          ),
        ),
      ),
    );
  }

  ListView _setupListView(LogoSearchStore store) => ListView.builder(
      shrinkWrap: true,
      itemCount: store.state.logoInfos.length,
      itemBuilder: (context, index) {
        return _setupListRow(index, store);
      });

  Widget _setupListRow(int index, LogoSearchStore store) {
    final logoInfos = store.state.logoInfos;
    final logoInfo = logoInfos[index];
    final row = SearchLogoTableRow(
        logoInfo: logoInfo,
        onDetailPressed: () {
          DetailRoute detailRoute = DetailRoute.instance;
          store.state.selectedLogoInfoAt(index);

          Routes.next(detailRoute, context, store);
        });

    return row;
  }

// - Actions -
  void _sendSearchAction(LogoSearchStore store) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (_searchText.isEmpty) {
      return;
    }

    BrandSearchRequest request = BrandSearchRequest(_searchText);
    LogoSearchAction action = LogoSearchAction.search(request);

    store.dispatch(action);
  }
}

class _SearchBar extends StatelessWidget {
  final ValueChanged<String> onInputChanged;

  final VoidCallback onSearchPressed;

  const _SearchBar({
    required this.onInputChanged,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 35.0,
        child: Row(
          children: [
            // 搜尋輸入框
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter brand name...",
                  hintStyle: TextStyle(color: CustomColors.text.hint),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 8.0), // 調整內部間距
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: CustomColors.borderLine),
                  ),
                ),
                style: TextStyle(color: CustomColors.text.primary),
                onChanged: onInputChanged,
              ),
            ),
            const SizedBox(width: 10.0), // 按鈕與輸入框的間距
            // 搜尋按鈕
            ElevatedButton(
              onPressed: onSearchPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.button.background,
                foregroundColor: CustomColors.button.foreground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Search"),
            ),
          ],
        ),
      );
}
