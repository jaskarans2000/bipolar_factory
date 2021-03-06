import 'package:bipolarfactory/Model/tabModel.dart';
import 'package:bipolarfactory/Network/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ImageGrid extends StatefulWidget {
  final int index;

  const ImageGrid({Key key, this.index}) : super(key: key);
  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  Future <AutogeneratedList> imagesObject;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getimageObject(widget.index);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: imagesObject,
          builder: (context,AsyncSnapshot<AutogeneratedList> snapShot){
            if(snapShot.hasData){
              print(snapShot.data.objects[0]);
              return createGridView(snapShot.data,context);
            }
            else{
              return Container(
                child: Center(
                  child: SpinKitFadingCircle(color: Colors.grey.shade300),
                ),
              );
            }
          }),
    );
  }

  void getimageObject(int i) {
    setState(() {
      imagesObject=Network().getImages(i);
    });
    imagesObject.then((onValue){
      print(onValue);
    });
  }

  Widget createGridView(AutogeneratedList data, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:18.0),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        scrollDirection: Axis.vertical,
        children: List.generate(data.objects.length, (index) {
          return createImage(data.objects[index]);
        }),
      ),
    );
  }

  createImage(Autogenerated object) {
    String url=object.urls.full;
    String description=object.altDescription;
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(url),fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        Center(child: Text(description??" ",
        style: TextStyle(color: Colors.grey.shade300),)),
      ],
    );
  }
}
