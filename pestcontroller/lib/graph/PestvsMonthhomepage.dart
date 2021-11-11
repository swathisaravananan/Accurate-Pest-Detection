//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'PestvsMonth.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PestvsMonthHomePage extends StatefulWidget {
  @override
  _PestvsMonthHomePageState createState() {
    return _PestvsMonthHomePageState();
  }
}

class _PestvsMonthHomePageState extends State<PestvsMonthHomePage> {
  List<charts.Series<PestvsMonth, String>> _seriesBarData;
  List<PestvsMonth> mydata;
  _generateData(mydata) {
    _seriesBarData = List<charts.Series<PestvsMonth, String>>();
    _seriesBarData.add(
      charts.Series(
        domainFn: (PestvsMonth graph1, _) => graph1.month.toString(),
        measureFn: (PestvsMonth graph1, _) => graph1.count,
        colorFn: (PestvsMonth graph1, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(graph1.colorVal))),
        id: 'Graph Analysis',
        data: mydata,
        labelAccessorFn: (PestvsMonth row, _) => "${row.month}",
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Graph Analysis')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('pest vs months').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<PestvsMonth> graph1 = snapshot.data.docs.map((documentSnapshot) => PestvsMonth.fromMap(documentSnapshot.data())).toList();
          return _buildChart(context, graph1);
        }
      },
    );
  }
  Widget _buildChart(BuildContext context, List<PestvsMonth> pestdata) {
    mydata = pestdata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Pest VS Month',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.BarChart(_seriesBarData,
                    animate: true,
                    animationDuration: Duration(seconds:5),
                     behaviors: [
                      new charts.DatumLegend(
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.purple.shadeDefault,
                            fontFamily: 'Georgia',
                            fontSize: 18),
                      )
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}