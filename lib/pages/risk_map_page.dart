import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../services/api_service.dart';

class RiskMapPage extends StatefulWidget {
  @override
  _RiskMapPageState createState() => _RiskMapPageState();
}

class _RiskMapPageState extends State<RiskMapPage> {
  List<dynamic>? _geoJsonData;
  Map<String, int> _riskData = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _fetchGeoJsonData();
    await _fetchRiskData();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchGeoJsonData() async {
    final String response = await rootBundle.loadString('assets/china_map.geojson');
    final decodedData = json.decode(response);
    setState(() {
      _geoJsonData = decodedData['features'];
    });
  }

  Future<void> _fetchRiskData() async {
    final apiService = ApiService();
    final data = await apiService.mockFetchRiskDataByRegion('total');
    setState(() {
      _riskData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('风险分布地图'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: LatLng(35.86166, 104.195397),
                zoom: 4.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                PolygonLayer(
                  polygons: _geoJsonData!.map((feature) {
                    final coordinates = _parseCoordinates(feature['geometry']['coordinates'][0]);
                    final areaName = feature['properties']['name'];
                    final riskCount = _riskData[areaName] ?? 0;

                    return Polygon(
                      points: coordinates,
                      borderColor: Colors.black,
                      borderStrokeWidth: 1.0,
                      isFilled: true,
                      color: _getRiskColor(riskCount),
                    );
                  }).toList(),
                ),
                MarkerLayer(
                  markers: _geoJsonData!.map((feature) {
                    final coordinates = _parseCoordinates(feature['geometry']['coordinates'][0]);
                    final areaName = feature['properties']['name'];
                    final riskCount = _riskData[areaName] ?? 0;
                    print(_riskData);
                    final centroid = _calculateCentroid(coordinates);

                    return Marker(
                      point: centroid,
                      builder: (context) => Container(

                        child: Text(
                          '$riskCount',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );

                  }).toList(),
                ),
              ],
            ),
    );
  }

  List<LatLng> _parseCoordinates(List<dynamic> coords) {
    return coords[0].map<LatLng>((coord) {
      if (coord is List) {
        double longitude = coord[0].toDouble();
        double latitude = coord[1].toDouble();
        return LatLng(latitude, longitude);
      } else {
        throw Exception('Invalid coordinate format');
      }
    }).toList();
  }

  Color _getRiskColor(int count) {
    if (count > 200) {
      return Colors.red.withOpacity(0.7);
    } else if (count > 100) {
      return Colors.orange.withOpacity(0.7);
    } else if(count==0){
      return Colors.white.withOpacity(0.7);
    }else{

      return Colors.green.withOpacity(0.7);
    }
  }

  LatLng _calculateCentroid(List<LatLng> points) {
    double x = 0.0;
    double y = 0.0;
    int count = points.length;

    for (var point in points) {
      x += point.latitude;
      y += point.longitude;
    }

    return LatLng(x / count, y / count);
  }
}
