class Pestcount {
  final int count;
  final String pest;
  final String colorVal;
  Pestcount(this.pest,this.count,this.colorVal);

  Pestcount.fromMap(Map<String, dynamic> map)
      : assert(map['pest'] != null),
        assert(map['count'] != null),
        assert(map['colorVal'] != null),
        pest = map['pest'],
        count = map['count'],
        colorVal=map['colorVal'];

  @override
  String toString() => "Record<$count:$pest>";
}