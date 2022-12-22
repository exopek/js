import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:visu/customWidgets/header.dart';
import 'package:visu/responsive/responsive.dart';
import 'package:visu/services/helper_services.dart';
import 'package:visu/services/openhab_service.dart';

class Openhab extends StatefulWidget {
  const Openhab({Key? key}) : super(key: key);

  @override
  _OpenhabState createState() => _OpenhabState();
}

class _OpenhabState extends State<Openhab> {
  List openhabContent = ['Listenansicht', 'Kachelansicht'];
  List<Widget> images = [
    const Image(
      image: AssetImage(''),
      fit: BoxFit.fitWidth,
    ),
    const Image(image: AssetImage('habpanel.png'), fit: BoxFit.fill)
  ];
  List<String> assetPath = ['assets/basicui.png', 'assets/habpanel.png'];

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return FutureBuilder<dynamic>(
        future: OpenhabServices().getIP(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            print('Hallooooo');
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
                                  defaultPadding: 16.0,
                                  openhabList: openhabContent,
                                  images: images,
                                  assetPath: assetPath),
                              tablet: _grid(context,
                                  crossAxisCount: 4,
                                  childAspectRatio: 1,
                                  defaultPadding: 16.0,
                                  openhabList: openhabContent,
                                  images: images,
                                  assetPath: assetPath),
                              desktop: _grid(context,
                                  childAspectRatio:
                                      _size.width < 1400 ? 1.1 : 1.4,
                                  crossAxisCount: 4,
                                  defaultPadding: 16.0,
                                  openhabList: openhabContent,
                                  images: images,
                                  assetPath: assetPath),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
            );
          } else {
            return Container(
              color: Theme.of(context).primaryColor,
            );
          }
        });
  }
}

Widget _grid(BuildContext context,
    {required crossAxisCount,
    required defaultPadding,
    required childAspectRatio,
    required openhabList,
    required images,
    required assetPath}) {
  return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 2,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => FutureBuilder<Image>(
          future: Helper().loadAsset(assetPath: assetPath[index]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)))),
                    onPressed: () {},
                    child: snapshot.data!,
                  )
                  /*Stack(
                fit: StackFit.expand,
                children: [
                  //images[index],
                  TextButton(
                      onPressed: () {},
                      child: Text(openhabList[index]),)
                ],
              ),
            */

                  );
            } else {
              return Container();
            }
          }));
}
