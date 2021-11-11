//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:pestcontroller/components/rounded_button.dart';
import 'package:pestcontroller/graph/graphpage.dart';

class ViewDetails extends StatefulWidget {
  int count = 0;
  String name = '';
  int region = 0;
  String i = " ";
  ViewDetails(this.count, this.name, this.region, this.i);

  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  int ind = 0;
  void conv() {
    print("Index number is: ${widget.i}");

    if (widget.i == '0')
      ind = 0;
    else if (widget.i == '1') {
      ind = 1;
    } else if (widget.i == '2') {
      ind = 2;
    } else {
      ind = 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    conv();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                color: Colors.green,
                boxShadow: [new BoxShadow(blurRadius: 40.0)],
                borderRadius: new BorderRadius.vertical(
                    bottom: new Radius.elliptical(
                        MediaQuery.of(context).size.width, 50.0)),
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Text(
                  'View Details',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Pest Identified: ${detailservices[ind].name}',
                    style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.w200,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No of pests: ${widget.count}',
                    style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.w200,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Region: ${widget.region}',
                    style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.w200,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Inference: ',
                    style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.w700,
                        fontSize: 24),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('${detailservices[ind].inference}'),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Solution:',
                    style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.w700,
                        fontSize: 24),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('${detailservices[ind].solution}'),
                  SizedBox(
                    height: 40,
                  ),
                  RoundedButton(
                    text: "Graph Analysis",
                    press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GraphHomePage()));
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                color: Colors.green,
                boxShadow: [new BoxShadow(blurRadius: 20.0)],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50)),
              ),
              child: Center(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 38.0),
                      child: Column(
                        children: [
                          Text(
                            'View Details',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 24),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}

class Detailservices {
  String inference;
  String solution;
  String name;

  Detailservices({
    @required this.inference,
    @required this.solution,
    @required this.name,
  });
}

List<Detailservices> detailservices = [
  Detailservices(inference: 'Affected plant dries up and gives a scorched appearance called “hopper burn”. Circular patches of drying and lodging of matured plant .Ovipositional marks exposing the plant to fungal and bacterial infections',solution:'	Drain the water before use of insecticides and direct the spray towards the base of the plants .Apply Neem oil 3% 15 lit/ha .Apply Phosalone 35 EC 1500 ml/ha.',name: 'Brown plant hopper'),
  Detailservices(inference: 'Yellowing of leaves from tip to downwards Vector for the diseases viz., Rice tungro virus, rice yellow & transitory yellowing cause direct damage to the rice plant .Retarded vigorous and stunted growth', solution: 'Spray Phosphamidon 40 SL 50 ml or Phosalone 35 EC 120 ml. Maintain 2.5 cm of water in the nursery and broadcast Carbofuran 3 G 3.5 kg of the following in 20 cents', name: 'Green Leaf Hopper'),
  Detailservices(inference: 'Leaves fold longitudinally and some leaf folder larvae may remain inside. Scraping of green tissues of the leaves, becomes white and dry .During severe infestation the whole field exhibits scorched appearance', solution: 'Release Trichogramma chilonis @5 cc (1,00,000/ha) thrice at 37, 44 and 51 days .Avoid excessive nitrogenous fertilizers .Spray NSKE 5 % or carbaryl 50 WP 1 Kg or chlorpyriphos 20 EC 1250 ml/ ha', name: 'Leaf Folder'),
  Detailservices(inference: 'Caterpillar bore into central shoot of paddy seedling and tiller, causes drying of the central shoot known as “dead heart” . Grown up plant whole panicle becomes dried white ear. Plants could be easily pulled by hand', solution: 'Trichogramma japonicum  for the management of the rice yellow stem borer .Spraying Neem seed kernel extract controls stem borer .Spraying Acephate 75 % SP 666-1000 g/ha',name: 'Yellow Stem Borer'),
];
