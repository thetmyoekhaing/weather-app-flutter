import 'package:flutter/material.dart';
import 'package:weather_app/api/api_model.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String temp = '';
  String city = '';
  String wind = '';
  String windDeg = '';
  late DateTime now;
  late String dateString;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    dateString = DateFormat('EEEE, MMMM d, y').format(now);
    _fetchData();
  }

  Future<void> _fetchData() async {
    // https://api.openweathermap.org/data/2.5/weather?q=Yangon&appid=2f40b6f112a43c4992273be8111a4edd&units=metric
    const String cityName = "Yangon";
    const String apiKey = "2f40b6f112a43c4992273be8111a4edd";
    const String units = "metric";
    const url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=$units";
    final api =
        FetchApi(url: url, apiKey: apiKey, cityName: cityName, units: units);

    try {
      final data = await api.fetchData();
      setState(() {
        city = data['name'];
        temp = data['main']['temp'].toString();
        wind = data['wind']['speed'].toString();
        windDeg = data['wind']['deg'].toString();
      });
    } catch (e) {
      debugPrint('Error fetching data: $e');
      // handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text(
            'Weather Forecast',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/sunny.jpg'),
                  fit: BoxFit.cover,
                  opacity: .9),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  city,
                  style: const TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  dateString,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "$temp°c",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 50,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "-------------",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Wind",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Speed $wind/$windDeg°c",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
