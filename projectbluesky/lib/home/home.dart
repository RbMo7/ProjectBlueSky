import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for sample data loading
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  var now = DateTime.now();
  List<dynamic> aqi = [];

  // Fetch data from a real API (replace with your actual API endpoint)
  final String apiUrl = 'http://10.0.2.2:8000/api';

  Future<dynamic> fetchData() async {
    print("Helloooooooo");
    try {
      final uri = Uri.parse(apiUrl);
      final response = await http.get(uri);
      final body = response.body;
      final gg = body[1];
      print(gg);

      final json = jsonDecode(body);
      print("heyyyyyy");

      // Extract AQI value from the JSON response structure (modify based on your API)
      final aqiValue = json['yhat'];
      setState(() {
        aqi = [aqiValue];
      });
      print(aqi);
      print(aqi.length);
      return aqiValue;
    } catch (error) {
      print('Error fetching data: $error');
      return null; // Handle API errors gracefully (display error message)
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display numeric value of air quality for today
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
              child: FutureBuilder(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      child: Text("Loading"),
                    );
                  } else if (!snapshot.hasData || aqi.isEmpty) {
                    return const Text('Error fetching data. Please try again.');
                  } else {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _buildAirQualityWidget(1)),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Column(
                          children: [
                            Text(
                              aqi[0].toString(),
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
                    );
                  }
                },
              ),
            ),
            FutureBuilder(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _buildAirQualityWidget(1),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              _levelofAirQuality(2),
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
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
                    7,
                    (index) => Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              now.month.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Text("/"),
                            Text((now.day + index).toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 15, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: _buildDailyForecastWidget(1),
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

  Color _buildAirQualityWidget<Widget>(int airQualityIndex) {
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
          '$data',
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }

  // Color _getLungsColor(int airQualityIndex) {
  //   if (airQualityIndex <= 50) {
  //     return const Color.fromARGB(255, 247, 247, 247);
  //   } else if (airQualityIndex <= 100) {
  //     return Colors.grey.shade700;
  //   } else if (airQualityIndex <= 150) {
  //     return Colors.grey.shade800;
  //   } else if (airQualityIndex <= 200) {
  //     return Colors.grey.shade900;
  //   } else {
  //     return Colors.black87;
  //   }
  // }
}

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}
