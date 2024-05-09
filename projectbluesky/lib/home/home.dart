import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for sample data loading
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DateTime now;
  List<dynamic> aqi = [];
  bool isLoading = true;
  // Fetch data from a real API (replace with your actual API endpoint)
  final String apiUrl = 'http://10.0.2.2:8000/api';

  @override
  void initState() {
    super.initState();
    fetchData();
    now = DateTime.now();
  }

  Future<void> fetchData() async {
    print("Helloooooooo");
    try {
      final uri = Uri.parse(apiUrl);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      print("heyyyyyy");

      // Extract AQI value from the JSON response structure (modify based on your API)
      final aqiValue = json['yhat'];
      setState(() {
        aqi = aqiValue;
        isLoading = false;
      });
      print(aqi);
    } catch (error) {
      print('Error fetching data: $error');
      // Handle API errors gracefully (display error message)
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Air Quality Index',
          style:
              GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Display numeric value of air quality for today
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _buildAirQualityWidget(aqi[0].round())),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Column(
                          children: [
                            Text(
                              aqi[0].round().toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 60,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "last updated on ${DateTime.now().toString()}",
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _buildAirQualityWidget(aqi[0].round()),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            _levelofAirQuality(aqi[0].round()),
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Weekly Forecast',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Display forecast for 7 days horizontally
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: List.generate(
                          aqi.length,
                          (index) => Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    now.month.toString(),
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text("/"),
                                  Text((now.day + index).toString(),
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: _buildDailyForecastWidget(
                                    aqi[index].round()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Display lungs photo below today's forecast
                ],
              ),
      ),
    );
  }

  Color _buildAirQualityWidget(int airQualityIndex) {
    Color color;

    if (airQualityIndex <= 50) {
      color = Colors.green;
    } else if (airQualityIndex <= 100) {
      color = Colors.yellow.shade800;
    } else if (airQualityIndex <= 150) {
      color = Colors.orange;
    } else if (airQualityIndex <= 200) {
      color = Colors.red;
    } else {
      color = Colors.purple;
    }
    return color;
  }

  String _levelofAirQuality(int aqi) {
    String level;

    if (aqi <= 50) {
      level = "Good";
    } else if (aqi < 101) {
      level = 'Moderate';
    } else if (aqi < 151) {
      level = "Unhealthy for Sensitive Groups";
    } else if (aqi < 200) {
      level = "Unhealthy";
    } else if (aqi < 300) {
      level = "Very Unhealthy";
    } else if (aqi < 400) {
      level = "Hazardous";
    } else {
      level = "Very Hazardous";
    }
    return level;
  }

  Widget _buildDailyForecastWidget(int data) {
    return Container(
      width: 60,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _buildAirQualityWidget(data),
      ),
      child: Center(
        child: Text(
          data.toString(),
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}
