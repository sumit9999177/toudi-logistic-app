import 'package:flutter/material.dart';

void main() {
  runApp(const ToudiApp());
}

class ToudiApp extends StatelessWidget {
  const ToudiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toudi Logistic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

// ================= C-01: LOGIN SCREEN =================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  void _sendOtp() {
    if (_phoneController.text.length == 10) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('10 digit ka mobile number daalo!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_shipping, size: 100, color: Colors.blue),
              const SizedBox(height: 20),
              const Text('Toudi Logistic', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('On-Demand Goods Transport'),
              const SizedBox(height: 40),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendOtp,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text('Send OTP', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= C-04: HOME / MAP SCREEN =================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Delivery'), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: Stack(
        children: [
          // Map Placeholder
          Container(
            color: Colors.grey[200],
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 100, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('Map Yahan Aayega', style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            ),
          ),
          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Kahan se uthana hai?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PickupDropScreen()));
                    },
                    icon: const Icon(Icons.add_location),
                    label: const Text('Naya Delivery Book Karo'),
                    style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= C-05: PICKUP & DROP SCREEN =================
class PickupDropScreen extends StatelessWidget {
  const PickupDropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pickup & Drop'), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Pickup Address',
                prefixIcon: const Icon(Icons.my_location, color: Colors.green),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Drop Address',
                prefixIcon: const Icon(Icons.location_on, color: Colors.red),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const VehicleSelectionScreen()));
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              child: const Text('Aage Badho'),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= C-07: VEHICLE SELECTION SCREEN =================
class VehicleSelectionScreen extends StatefulWidget {
  const VehicleSelectionScreen({super.key});
  @override
  State<VehicleSelectionScreen> createState() => _VehicleSelectionScreenState();
}

class _VehicleSelectionScreenState extends State<VehicleSelectionScreen> {
  int selectedIndex = 0;
  final List<Map<String, String>> vehicles = [
    {'name': '2-Wheeler', 'price': '₹50', 'icon': '🏍️'},
    {'name': '3-Wheeler', 'price': '₹100', 'icon': '🛺'},
    {'name': 'Tata Ace', 'price': '₹200', 'icon': '🚚'},
    {'name': 'Pickup', 'price': '₹300', 'icon': '🛻'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vehicle Select Karo'), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  color: selectedIndex == index ? Colors.blue[50] : Colors.white,
                  child: ListTile(
                    leading: Text(vehicles[index]['icon']!, style: const TextStyle(fontSize: 30)),
                    title: Text(vehicles[index]['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Base Fare: ${vehicles[index]['price']}'),
                    trailing: selectedIndex == index ? const Icon(Icons.check_circle, color: Colors.blue) : null,
                    onTap: () => setState(() => selectedIndex = index),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FindingDriverScreen()));
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              child: const Text('Confirm Booking'),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= C-12: FINDING DRIVER SCREEN =================
class FindingDriverScreen extends StatefulWidget {
  const FindingDriverScreen({super.key});
  @override
  State<FindingDriverScreen> createState() => _FindingDriverScreenState();
}

class _FindingDriverScreenState extends State<FindingDriverScreen> {
  @override
  void initState() {
    super.initState();
    // 3 second baad automatic Driver Assigned screen par le jayega
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DriverAssignedScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Driver Dhoondh Rahe Hain...', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

// ================= C-13: DRIVER ASSIGNED SCREEN =================
class DriverAssignedScreen extends StatelessWidget {
  const DriverAssignedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Driver Mil Gaya!'), backgroundColor: Colors.green, foregroundColor: Colors.white),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 20),
            const Text('Ramesh Kumar', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text('Tata Ace - UP 32 AB 1234'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.call), label: const Text('Call')),
                const SizedBox(width: 20),
                ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.message), label: const Text('Message')),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Wapas Home par le jao
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Naya Order Karo'),
            ),
          ],
        ),
      ),
    );
  }
}
