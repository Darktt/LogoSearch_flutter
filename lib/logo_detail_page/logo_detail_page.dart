import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logo_search/models/colors.dart';
import 'package:logo_search/models/brand_search_response.dart';
import 'package:logo_search/models/dropdown_list.dart';
import 'package:logo_search/models/logo_image_fallback.dart';
import 'package:logo_search/models/logo_image_format.dart';
import 'package:logo_search/models/logo_image_request.dart';
import 'package:logo_search/models/rounded_container.dart';
import 'package:logo_search/models/text_styles.dart';
import 'package:logo_search/view_model/logo_search_action.dart';
import 'package:logo_search/view_model/logo_search_state.dart';
import 'package:logo_search/view_model/logo_search_store.dart';

class LogoDetailPage extends StatefulWidget {
  const LogoDetailPage({super.key});

  @override
  State<LogoDetailPage> createState() => _LogoDetailPageState();
}

class _LogoDetailPageState extends State<LogoDetailPage> {
  double get bottomInset => MediaQuery.of(context).padding.bottom;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final store = context.read<LogoSearchStore>();
      final state = store.state;

      if (state.selectedLogoInfo != null) {
        _imageRequestAction(store);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<LogoSearchStore>();
    final LogoSearchState state = store.state;

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        title: Text('Logo Image'),
        centerTitle: true,
        backgroundColor: CustomColors.background,
        foregroundColor: CustomColors.foreground,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0 + bottomInset),
        child: Column(
          spacing: 10.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Preview(
              imageBytes: state.imageBytes,
              size: state.size,
              onPressed: _downloadLogoAction,
            ),
            _setupControlPanel(store),
          ],
        ),
      ),
    );
  }

  Widget _setupControlPanel(LogoSearchStore store) {
    final state = store.state;

    return RoundedContainer(
      radius: 6.0,
      borderColor: CustomColors.borderLine,
      padding: EdgeInsets.all(15.0),
      child: Column(
        spacing: 10.0,
        children: [
          _DomainPanel(logoInfo: state.selectedLogoInfo!),
          _SizePanel(
            size: state.size,
            onChanged: (value) => setState(() {
              state.size = value;
            }),
            onChangeEnd: (value) => _imageRequestAction(store),
          ),
          _SwitchPanel(
            title: 'Greyscale',
            value: state.isGreyscale,
            onChanged: (value) => setState(() {
              state.isGreyscale = value;
              _imageRequestAction(store);
            }),
          ),
          _SwitchPanel(
            title: 'Retina',
            value: state.isRetina,
            onChanged: (value) => setState(() {
              state.isRetina = value;
              _imageRequestAction(store);
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
              _imageRequestAction(store);
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
              _imageRequestAction(store);
            }),
          ),
        ],
      ),
    );
  }

  void _downloadLogoAction() {
    final store = context.read<LogoSearchStore>();
    final state = store.state;

    if (state.imageBytes.isEmpty) {
      return;
    }

    final mimeType = (store.state.format == LogoImageFormat.jpg)
        ? 'image/jpeg'
        : 'image/png';
    final file = XFile.fromData(state.imageBytes, mimeType: mimeType);

    Share.shareXFiles([file]);
  }

  void _imageRequestAction(LogoSearchStore store) {
    final state = store.state;
    final domain = state.selectedLogoInfo?.domain ?? '';
    final size = state.size;
    final isGreyscale = state.isGreyscale;
    final isRetina = state.isRetina;
    final format = state.format;
    final fallback = state.fallback;

    LogoImageRequest request = LogoImageRequest.image(domain)
      ..size = size
      ..isGreyscale = isGreyscale
      ..isRetina = isRetina
      ..format = format
      ..fallback = fallback;

    final action = LogoSearchAction.imageRequest(request);

    store.dispatch(action);
  }
}

class _Preview extends StatelessWidget {
  final Uint8List imageBytes;
  final double size;
  final VoidCallback? onPressed;

  const _Preview(
      {required this.imageBytes, required this.size, required this.onPressed});

  @override
  Widget build(BuildContext context) => RoundedContainer(
        radius: 6.0,
        borderColor: CustomColors.borderLine,
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            _PreviewImage(
              imageBytes: imageBytes,
              size: size,
            ),
          ],
        ),
      );
}

class _PreviewImage extends StatelessWidget {
  final Uint8List imageBytes;
  final double size;

  const _PreviewImage({required this.imageBytes, required this.size});

  @override
  Widget build(BuildContext context) => RoundedContainer(
        radius: 6.0,
        borderColor: CustomColors.borderLine,
        padding: EdgeInsets.all(1.0),
        child: Container(
          constraints: BoxConstraints(minHeight: 50.0),
          height: size,
          child: (imageBytes.isNotEmpty) ? Image.memory(imageBytes) : null,
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
  final ValueChanged<double> onChangeEnd;

  const _SizePanel({
    required this.size,
    this.onChanged,
    required this.onChangeEnd,
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
            onChangeEnd: onChangeEnd,
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
