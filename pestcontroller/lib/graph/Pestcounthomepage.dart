//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Pestcount.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PestcountHomePage extends StatefulWidget {
  @override
  _PestcountHomePageState createState() {
    return _PestcountHomePageState();
  }
}

class _PestcountHomePageState extends State<PestcountHomePage> {
  List<charts.Series<Pestcount, String>> _seriesPieData;
  List<Pestcount> mydata;
  _generateData(mydata) {
    _seriesPieData = List<charts.Series<Pestcount, String>>();
    _seriesPieData.add(
      charts.Series(
        domainFn: (Pestcount task, _) => task.pest,
        measureFn: (Pestcount task, _) => task.count,
        colorFn: (Pestcount task, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(task.colorVal))),
        id: 'Graph Analysis',
        data: mydata,
        labelAccessorFn: (Pestcount row, _) => "${row.count}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pest vs Count')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('pest vs count').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Pestcount> task = snapshot.data.docs.map((documentSnapshot) => Pestcount.fromMap(documentSnapshot.data())).toList();
          return _buildChart(context, task);
        }
      },
    );
  }
  Widget _buildChart(BuildContext context, List<Pestcount> taskdata) {
    mydata = taskdata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Pest population in a month',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.PieChart(_seriesPieData,
                    animate: true,
                    animationDuration: Duration(seconds: 5),
                    behaviors: [
                      new charts.DatumLegend(
                        outsideJustification:
                            charts.OutsideJustification.endDrawArea,
                        horizontalFirst: false,
                        desiredMaxRows: 2,
                        cellPadding:
                            new EdgeInsets.only(right: 4.0, bottom: 4.0,top:4.0),
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.purple.shadeDefault,
                            fontFamily: 'Georgia',
                            fontSize: 18),
                      )
                    ],
                    defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 100,
                        arcRendererDecorators: [
                          new charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside)
                        ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}