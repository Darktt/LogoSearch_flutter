import 'package:flutter/material.dart';
import 'package:logo_search/models/colors.dart';
import 'package:logo_search/models/brand_search_response.dart';
import 'package:logo_search/models/text_styles.dart';

class LogoDetailPage extends StatefulWidget {
  const LogoDetailPage({super.key});

  @override
  State<LogoDetailPage> createState() => _LogoDetailPageState();
}

class _LogoDetailPageState extends State<LogoDetailPage> {
  late LogoInfo logoInfo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logoInfo = ModalRoute.of(context)!.settings.arguments as LogoInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logo Image'),
        centerTitle: true,
        backgroundColor: CustomColors.background,
        foregroundColor: CustomColors.foreground,
      ),
      body: Container(
        color: CustomColors.background,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _setupPreview(),
                _setupControlPanel(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _setupPreview() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.borderLine, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Preview',
                  style: TextStyles.title2.withColor(CustomColors.text.primary),
                ),
                OutlinedButton.icon(
                  onPressed: _downloadLogoAction,
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
            _previewImage(),
          ],
        ),
      ),
    );
  }

  Widget _previewImage() {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 50.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: CustomColors.borderLine, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Padding(
          padding: EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(logoInfo.imageUrl ?? ''),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _setupControlPanel() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.borderLine, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            _setupDomainPanel(),
          ],
        ),
      ),
    );
  }

  Widget _setupDomainPanel() {
    return Column(
      spacing: 10.0,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Domain',
          style: TextStyles.caption1.withColor(CustomColors.text.primary),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: CustomColors.borderLine, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          child: Padding(
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
        ),
      ],
    );
  }

  void _downloadLogoAction() {}
}
