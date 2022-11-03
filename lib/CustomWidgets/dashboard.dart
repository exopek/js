import 'package:flutter/material.dart';
import 'package:visu/CustomWidgets/header.dart';
import 'package:visu/Responsive/responsive.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Responsive(
                      mobile: _grid(context,
                          crossAxisCount: _size.width < 650 ? 2 : 4,
                          childAspectRatio: _size.width < 650 ? 1.3 : 1,
                          defaultPadding: 16.0),
                      tablet: _grid(context,
                          crossAxisCount: 4,
                          childAspectRatio: 1,
                          defaultPadding: 16.0),
                      desktop: _grid(context,
                          childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
                          crossAxisCount: 4,
                          defaultPadding: 16.0),
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
