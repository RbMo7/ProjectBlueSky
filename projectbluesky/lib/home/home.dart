import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Sample data for air quality forecast
  List<int> airQualityForecast = [10, 60, 70, 65, 55, 45, 40];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Air Quality Forecast'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Today\'s Air Quality Index',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Display numeric value of air quality for today
            _buildAirQualityWidget(airQualityForecast[0]),
             Image.asset(
              'assets/lungs.png',
              width: 300,
              height: 300,
              // color: _getLungsColor(airQualityForecast[0]),
            ),
            const SizedBox(height: 20),
            const Text(
              '7-Day Forecast',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Display forecast for 7 days horizontally
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  7,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: _buildDailyForecastWidget(airQualityForecast[index]),
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

  Widget _buildAirQualityWidget(int airQualityIndex) {
    IconData iconData;
    Color color;

    if (airQualityIndex <= 50) {
      iconData = Icons.check_circle;
      color = Colors.green;
    } else if (airQualityIndex <= 100) {
      iconData = Icons.info;
      color = Colors.yellow;
    } else if (airQualityIndex <= 150) {
      iconData = Icons.warning;
      color = Colors.orange;
    } else if (airQualityIndex <= 200) {
      iconData = Icons.dangerous;
      color = Colors.red;
    } else {
      iconData = Icons.cancel;
      color = Colors.purple;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: color,
          size: 40,
        ),
        const SizedBox(width: 10),
        Text(
          '$airQualityIndex',
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildDailyForecastWidget(int airQualityIndex) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey[100],
      ),
      child: Center(
        child: Text(
          '$airQualityIndex',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
