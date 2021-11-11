class PestvsMonth{
  final int count;
  final String month;
  final String colorVal;
  PestvsMonth(this.count,this.month,this.colorVal);

  PestvsMonth.fromMap(Map<String, dynamic> map)
      : assert(map['count'] != null),
        assert(map['month'] != null),
        assert(map['colorVal'] != null),
        count = map['count'],
        colorVal = map['colorVal'],
        month=map['month'];

  @override
  String toString() => "Record<$count:$month:$colorVal>";
}