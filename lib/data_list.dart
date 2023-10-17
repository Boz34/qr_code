import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

Future<MySqlConnection> openConnection() async {
  final settings = ConnectionSettings(
    host: 'db.triopt.de',
    port: 3306,
    user: 'junaid',
    password: 'y^ZJ3Dea',
    db: 'lager',
  );

  final conn = await MySqlConnection.connect(settings);
  if (kDebugMode) {
    print("Connected to MySQL database");
  }
  return conn;
}

Future<List<Map<String, dynamic>>> fetchScannedData() async {
  final MySqlConnection conn = await openConnection();

  try {
    final Results results =
        await conn.query("SELECT serialnummer, name FROM lager.lager");
    final List<Map<String, dynamic>> data = [];

    for (var row in results) {
      data.add({
        'serialnummer': row['serialnummer'],
        'name': row['name'],
      });
    }
    if (kDebugMode) {
      print(data);
    }

    return data;
  } catch (e) {
    if (kDebugMode) {
      print("Error: $e");
    }
    return [];
  } finally {
    await conn.close();
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScannedDataScreen(),
    );
  }
}

class ScannedDataScreen extends StatefulWidget {
  const ScannedDataScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ScannedDataScreenState createState() => _ScannedDataScreenState();
}

class _ScannedDataScreenState extends State<ScannedDataScreen> {
  List<Map<String, dynamic>> scannedData = [];

  Future<void> fetchAndSetData() async {
    final data = await fetchScannedData();
    setState(() {
      scannedData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAndSetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanned Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (scannedData.isEmpty) const Text('No scanned data available'),
            ListView.builder(
              itemCount: scannedData.length,
              itemBuilder: (context, index) {
                if (kDebugMode) {
                  print('Building item $index');
                }
                final item = scannedData[index];
                return ListTile(
                  title: Text(item['serialnummer']),
                  subtitle: Text(item['name']),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
