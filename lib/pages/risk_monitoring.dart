import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RiskMonitoring extends StatefulWidget {
  @override
  _RiskMonitoringState createState() => _RiskMonitoringState();
}

class _RiskMonitoringState extends State<RiskMonitoring> {
  List<dynamic> _riskData = [];
  bool _loading = true;
  String? _errorMessage;
  final ApiService _apiService = ApiService();
  final String _date = '2024-07-29';
  final String _type = 'msg';

  @override
  void initState() {
    super.initState();
    _fetchRiskData();
  }

  Future<void> _fetchRiskData() async {
    try {
      final data = await _apiService.fetchRiskData(_date, _type);
      setState(() {
        _riskData = data;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load risk data';
        _loading = false;
      });
      print('Error fetching risk data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(247, 248, 252, 1),
      padding: const EdgeInsets.all(16.0),
      child: _loading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!, style: TextStyle(color: Colors.red, fontSize: 18)))
              : ListView.builder(
                  itemCount: _riskData.length,
                  itemBuilder: (context, index) {
                    final item = _riskData[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4.0,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                        title: Text(
                          'ID: ${item['id']}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5.0),
                            Text('Type: ${item['type']}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black.withOpacity(0.7),
                                )),
                            SizedBox(height: 5.0),
                            Text('Count: ${item['count']}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black.withOpacity(0.7),
                                )),
                            SizedBox(height: 5.0),
                            Text('Summary: ${item['summary']}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black.withOpacity(0.7),
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
