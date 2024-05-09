import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Sample data for air quality forecast
  List<int> airQualityForecast = [100, 60, 70, 65, 55, 45, 40];
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Air Quality Index',
          style:
              GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display numeric value of air quality for today
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _buildAirQualityWidget(airQualityForecast[0])),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    children: [
                      Text(airQualityForecast[0].toString(),
                          style: GoogleFonts.poppins(
                              fontSize: 60,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                      Text("last updated on 9th May, 2024",
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
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
                    color: _buildAirQualityWidget(airQualityForecast[0])),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(_levelofAirQuality(airQualityForecast[0]),
                        style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
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
                          child: _buildDailyForecastWidget(
                              airQualityForecast[index]),
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

  String _levelofAirQuality<Widget>(int aqi) {
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

  Widget _buildDailyForecastWidget(int airQualityIndex) {
    return Container(
      width: 60,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _buildAirQualityWidget(airQualityIndex),
      ),
      child: Center(
        child: Text(
          '$airQualityIndex',
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
