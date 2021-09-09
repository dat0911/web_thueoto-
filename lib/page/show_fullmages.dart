import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowFullImage extends StatefulWidget {
  List<String> image;
  int currentImage;
  ShowFullImage({Key? key, required this.currentImage, required this.image})
      : super(key: key);

  @override
  _ShowFullImageState createState() => _ShowFullImageState();
}

class _ShowFullImageState extends State<ShowFullImage> {
  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (var i = 0; i < widget.image.length; i++) {
      list.add(buildIndicator(i == widget.currentImage));
    }
    return list;
  }

  Widget buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 6),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.grey[400],
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
            ),
            Expanded(
              child:  Container(
                  child: PageView(
                    physics: BouncingScrollPhysics(),
                    onPageChanged: (int page) {
                      setState(() {
                        widget.currentImage = page;
                      });
                    },
                    children: widget.image.map((path) {
                      return Container(
                        child: Image.network(
                          path,
                          fit: BoxFit.scaleDown,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            widget.image.length > 1
                ? Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: buildPageIndicator(),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
