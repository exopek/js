import 'package:flutter/material.dart';
import 'package:visu/CustomWidgets/header.dart';
import 'package:visu/Responsive/responsive.dart';
import 'package:webviewx/webviewx.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //late WebViewXController _webviewController;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            //const Header(),
            //const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Responsive(
                      mobile: _openhabWebView(
                          context, 'http://192.168.0.62:8080/basicui/app'),
                      tablet: _openhabWebView(
                          context, 'http://192.168.0.62:8080/basicui/app'),
                      desktop: _openhabWebView(
                          context, 'http://192.168.0.62:8080/basicui/app'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

Widget _openhabWebView(
  BuildContext context,
  String url,
) {
  return SingleChildScrollView(
    child: Container(
      width: MediaQuery.of(context).size.width,
      child: WebViewX(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        initialContent: '<h1>OpenHAB</h1>',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          controller.loadContent(url, SourceType.url);
        },
      ),
    ),
  );
}

Widget _grid(BuildContext context,
    {required crossAxisCount,
    required defaultPadding,
    required childAspectRatio}) {
  return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => Container(
            color: Theme.of(context).primaryColor,
            child: TextButton(
              child: Text('text'),
              onPressed: () {},
            ),
          ));
}
