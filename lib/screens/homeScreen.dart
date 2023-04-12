import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../utils/helper.dart';
import '../utils/apiClient.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen ";
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiClient _apiClient = ApiClient();
  var _arnie = [];

  bool _loader = false;
  ScrollController _controllerScroll = ScrollController(initialScrollOffset: 0);

  Future<void> setImpostazioni() async {
    bool loader = _loader;
    loader = true;

    var arnie = await ApiClient().getArnie();

    if (mounted) {
      setState(() => {
            _loader = loader,
            _arnie = arnie['results'],
          });
    }
  }

  @override
  void initState() {
    super.initState();
    setImpostazioni();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  _body(context) {
    if (!_loader) {
      return Scaffold(
          body: Center(
        child: LoadingAnimationWidget.threeArchedCircle(
          color: Color.fromARGB(180, 250, 4, 4),
          size: 80,
        ),
      ));
    }

    if (_loader) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: Helper.getScreenHeight(context),
            width: Helper.getScreenWidth(context),
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 30,
                ),
                child: Column(
                  children: [_buildContainer(_arnie)],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildContainer(api) {
    return Align(
      alignment: Alignment.bottomLeft + Alignment(0, -0.3),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200.0,
        child: ListView(
          controller: _controllerScroll,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            for (int i = 0; i < api.length; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _boxes(
                    api[i]['thumbnail_apiary_list_url'] ??
                        "https://www.ilverdemondo.it/public/blog/thumbs/icorpo-ape-operaia-regina-fuco-it-000.jpg",
                    api[i]['name'].toString(),
                    api[i]['name'].toString(),
                    api[i]['name'].toString(),
                    api[i]['name'].toString()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, String name, String descr1, String descr2,
      String restLoc) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(_image), fit: BoxFit.cover),
              ),
              child: myDetailsContainer1(name, restLoc, descr1, descr2),
            ),
          ],
        ),
      ),
    );
  }

  Widget myDetailsContainer1(
      String name, String restLoc, String descr1, String descr2) {
    return Column(
      children: <Widget>[
        Container(
            width: 200,
            height: 180,
            child: Text(
              name,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Color.fromARGB(255, 251, 251, 252),
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
