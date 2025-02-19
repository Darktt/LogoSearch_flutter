import 'package:flutter/material.dart';
import 'package:logo_search/models/colors.dart';
import 'package:logo_search/models/brand_search_response.dart';
import 'package:logo_search/models/dropdown_list.dart';
import 'package:logo_search/models/logo_image_fallback.dart';
import 'package:logo_search/models/logo_image_format.dart';
import 'package:logo_search/models/rounded_container.dart';
import 'package:logo_search/models/text_styles.dart';
import 'package:logo_search/view_model/logo_search_state.dart';
import 'package:logo_search/view_model/logo_search_store.dart';

typedef LogoImageFormatEntry = DropdownMenuEntry<LogoImageFormat>;
typedef LogoImageFallbackEntry = DropdownMenuEntry<LogoImageFallback>;

class LogoDetailPage extends StatefulWidget {
  const LogoDetailPage({super.key});

  @override
  State<LogoDetailPage> createState() => _LogoDetailPageState();
}

class _LogoDetailPageState extends State<LogoDetailPage> {
  late LogoSearchStore store;

  LogoSearchState get state => store.state;

  LogoInfo get logoInfo => state.selectedLogoInfo!;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    store = ModalRoute.of(context)!.settings.arguments as LogoSearchStore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Logo Image'),
        centerTitle: true,
        backgroundColor: CustomColors.background,
        foregroundColor: CustomColors.foreground,
      ),
      body: Container(
        color: CustomColors.background,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  spacing: 10.0,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Preview(
                        imageUrl: logoInfo.imageUrl ?? '',
                        onPressed: _downloadLogoAction),
                    _setupControlPanel(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _setupControlPanel() => RoundedContainer(
        radius: 6.0,
        borderColor: CustomColors.borderLine,
        padding: EdgeInsets.all(15.0),
        child: Column(
          spacing: 10.0,
          children: [
            _DomainPanel(logoInfo: logoInfo),
            _SizePanel(
              size: state.size,
              onChanged: (value) => setState(() {
                state.size = value;
              }),
            ),
            _SwitchPanel(
              title: 'Greyscale',
              value: state.isGreyscale,
              onChanged: (value) => setState(() {
                state.isGreyscale = value;
              }),
            ),
            _SwitchPanel(
              title: 'Retina',
              value: state.isRetina,
              onChanged: (value) => setState(() {
                state.isRetina = value;
              }),
            ),
            _DropdownPanel(
              title: 'Format',
              items: LogoImageFormat.values.map((LogoImageFormat value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value.description),
                );
              }).toList(),
              value: state.format,
              onChanged: (value) => setState(() {
                state.format = value ?? state.format;
              }),
            ),
            _DropdownPanel(
              title: 'Fallback',
              items: LogoImageFallback.values.map((LogoImageFallback value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value.description),
                );
              }).toList(),
              value: state.fallback,
              onChanged: (value) => setState(() {
                state.fallback = value ?? state.fallback;
              }),
            ),
          ],
        ),
      );

  void _downloadLogoAction() {}
}

class _Preview extends StatelessWidget {
  final String imageUrl;
  final VoidCallback? onPressed;

  const _Preview({required this.imageUrl, required this.onPressed});

  @override
  Widget build(BuildContext context) => RoundedContainer(
        radius: 6.0,
        borderColor: CustomColors.borderLine,
        padding: EdgeInsets.all(15.0),
        child: Column(
          spacing: 5.0,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Preview',
                  style: TextStyles.title2.withColor(CustomColors.text.primary),
                ),
                OutlinedButton.icon(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.download,
                    color: CustomColors.text.primary,
                  ),
                  label: Text(
                    'Download',
                    style: TextStyles.caption1
                        .withColor(CustomColors.text.primary),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: CustomColors.borderLine),
                  ),
                )
              ],
            ),
            _PreviewImage(imageUrl: imageUrl),
          ],
        ),
      );
}

class _PreviewImage extends StatelessWidget {
  final String imageUrl;

  const _PreviewImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) => RoundedContainer(
        radius: 6.0,
        borderColor: CustomColors.borderLine,
        padding: EdgeInsets.all(1.0),
        child: Container(
          constraints: BoxConstraints(minHeight: 50.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
}

class _DomainPanel extends StatelessWidget {
  final LogoInfo logoInfo;

  const _DomainPanel({required this.logoInfo});

  @override
  Widget build(BuildContext context) => Column(
        spacing: 10.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Domain',
            style: TextStyles.caption1.withColor(CustomColors.text.primary),
          ),
          RoundedContainer(
            radius: 6.0,
            borderColor: CustomColors.borderLine,
            padding: EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  logoInfo.domain ?? '',
                  style: TextStyles.caption2
                      .withColor(CustomColors.text.secondary),
                ),
              ],
            ),
          ),
        ],
      );
}

class _SizePanel extends StatelessWidget {
  final double size;
  final ValueChanged<double>? onChanged;

  const _SizePanel({
    required this.size,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Column(
        spacing: 10.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Size (${size.toInt()}px)',
            style: TextStyles.caption1.withColor(CustomColors.text.primary),
          ),
          Slider(
            value: size,
            onChanged: onChanged,
            max: 300.0,
            min: 16.0,
            activeColor: CustomColors.foreground,
            inactiveColor: CustomColors.borderLine,
          ),
        ],
      );
}

class _SwitchPanel extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const _SwitchPanel({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyles.caption1.withColor(CustomColors.text.primary),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: CustomColors.foreground,
            inactiveTrackColor: CustomColors.borderLine,
            thumbColor: WidgetStateProperty.all(CustomColors.background),
            trackOutlineWidth: WidgetStateProperty.all(0.0),
          ),
        ],
      );
}

class _DropdownPanel<T> extends StatelessWidget {
  final String title;
  final List<DropdownMenuItem<T>> items;
  final T value;
  final ValueChanged<T?>? onChanged;

  const _DropdownPanel({
    required this.title,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Column(
        spacing: 10.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyles.caption1.withColor(CustomColors.text.primary),
          ),
          SizedBox(
            height: 50.0,
            child: DropdownList(
              value: value,
              items: items,
              style: TextStyles.caption2.withColor(CustomColors.text.primary),
              backgroundColor: CustomColors.borderLine,
              onChanged: onChanged,
              radius: 6.0,
              borderColor: CustomColors.borderLine,
            ),
          ),
        ],
      );
}
