import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class RatingChart extends StatefulWidget {
  const RatingChart({super.key});

  @override
  _RatingChartState createState() => _RatingChartState();
}

class _RatingChartState extends State<RatingChart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 400,
            height: 250,
            child: Echarts(
              option: '''
              {
                tooltip: {
                  trigger: 'axis',
                  backgroundColor: 'rgba(255, 255, 255, 0.9)',
                  borderColor: '#e0e0e0',
                  borderWidth: 1,
                  textStyle: {
                    color: '#333333'
                  },
                  formatter: function(params) {
                    var data = params[0];
                    return data.name + '<br/>' +
                      '<span style="display:inline-block;margin-right:4px;border-radius:10px;width:10px;height:10px;background-color:#547474"></span>' +
                      'Ratings: ' + data.value;
                  }
                },
                xAxis: {
                  type: 'category',
                  data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                },
                yAxis: {
                  type: 'value'
                },
                series: [{
                  data: [820, 932, 901, 934, 1290, 1330, 1320],
                  type: 'line',
                  smooth: true,
                  symbol: 'circle',
                  symbolSize: 8,
                  itemStyle: {
                    color: '#547474',
                    borderColor: '#ffffff',
                    borderWidth: 2
                  },
                  lineStyle: {
                    color: '#547474',
                    width: 3
                  },
                  emphasis: {
                    itemStyle: {
                      color: '#2c3e50',
                      borderColor: '#ffffff',
                      borderWidth: 3
                    }
                  }
                }]
              }
              ''',
            ),
          )
        ],
      ),
    );
  }
}
