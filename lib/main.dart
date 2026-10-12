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
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
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
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                child: const Text('Send OTP', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= MAIN SCREEN (BOTTOM NAVIGATION) =================
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeTab(),
    const OrdersTab(),
    const AccountTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}

// ================= TAB 1: HOME (C-04) =================
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toudi Logistic'), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pick up from', style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.my_location, color: Colors.green),
                  SizedBox(width: 10),
                  Expanded(child: Text('Current Location', style: TextStyle(fontSize: 16))),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text('What do you want to move?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: _buildServiceTile(context, 'Trucks', Icons.local_shipping, Colors.blue)),
                const SizedBox(width: 15),
                Expanded(child: _buildServiceTile(context, '2 Wheeler', Icons.motorcycle, Colors.orange)),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: _buildServiceTile(context, 'Packers & Movers', Icons.inventory, Colors.purple)),
                const SizedBox(width: 15),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceTile(BuildContext context, String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const PickupDropScreen()));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// ================= TAB 2: ORDERS (C-17) =================
class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders'), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('2 Wheeler', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('₹${100 + index * 50}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(children: [Icon(Icons.circle, color: Colors.green, size: 12), SizedBox(width: 8), Text('Pickup Address')]),
                  const SizedBox(height: 5),
                  const Row(children: [Icon(Icons.circle, color: Colors.red, size: 12), SizedBox(width: 8), Text('Drop Address')]),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(5)),
                        child: const Text('COMPLETED', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Book Again'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ================= TAB 3: ACCOUNT (C-02, C-03) =================
class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account'), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Column(
              children: [
                CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
                SizedBox(height: 10),
                Text('Sumit Mathur', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('8373949014', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 30),
          _buildMenuItem(context, Icons.location_on, 'Saved Addresses', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SavedAddressesScreen()));
          }),
          _buildMenuItem(context, Icons.business, 'Business Details (GST)', () {}),
          _buildMenuItem(context, Icons.card_giftcard, 'Refer & Earn ₹200', () {}),
          _buildMenuItem(context, Icons.help, 'Help & Support', () {}),
          _buildMenuItem(context, Icons.language, 'Change Language', () {}),
          _buildMenuItem(context, Icons.description, 'Terms & Conditions', () {}),
          _buildMenuItem(context, Icons.logout, 'Logout', () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
          }),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}

// ================= C-03: SAVED ADDRESSES SCREEN =================
class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});
  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  final List<Map<String, String>> _addresses = [
    {'label': 'Home', 'address': 'A256, Mahalaxmi Enclave, New Mustafabad, Delhi - 110090', 'icon': 'home'},
  ];

  void _addAddress() {
    showDialog(
      context: context,
      builder: (context) {
        String newLabel = 'Other';
        String newAddress = '';
        return AlertDialog(
          title: const Text('Add New Address'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: newLabel,
                items: ['Home', 'Shop', 'Warehouse', 'Other'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) => newLabel = val!,
                decoration: const InputDecoration(labelText: 'Label'),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(labelText: 'Full Address'),
                onChanged: (val) => newAddress = val,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (newAddress.isNotEmpty) {
                  setState(() {
                    _addresses.add({'label': newLabel, 'address': newAddress, 'icon': 'location'});
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Addresses'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: _addAddress, icon: const Icon(Icons.add)),
        ],
      ),
      body: _addresses.isEmpty
          ? const Center(child: Text('Koi address save nahi hai. Add karo!'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                final addr = _addresses[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[50],
                      child: Icon(
                        addr['label'] == 'Home' ? Icons.home : (addr['label'] == 'Shop' ? Icons.store : Icons.location_on),
                        color: Colors.blue,
                      ),
                    ),
                    title: Text(addr['label']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(addr['address']!),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20, color: Colors.blue),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _addresses.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// ================= C-05 & C-06: PICKUP & DROP + RECEIVER INFO =================
class PickupDropScreen extends StatefulWidget {
  const PickupDropScreen({super.key});
  @override
  State<PickupDropScreen> createState() => _PickupDropScreenState();
}

class _PickupDropScreenState extends State<PickupDropScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropController = TextEditingController();
  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _receiverPhoneController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  
  String _saveAs = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pickup & Drop'), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _pickupController,
              decoration: InputDecoration(
                labelText: 'Pickup Address',
                prefixIcon: const Icon(Icons.my_location, color: Colors.green),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _dropController,
              decoration: InputDecoration(
                labelText: 'Drop Address',
                prefixIcon: const Icon(Icons.location_on, color: Colors.red),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 30),
            const Text('Receiver Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            TextField(
              controller: _receiverNameController,
              decoration: InputDecoration(
                labelText: "Receiver's Name",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _receiverPhoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Receiver's Mobile number",
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: "Note / Landmark (optional)",
                prefixIcon: const Icon(Icons.note),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 30),
            const Text('Save as (optional):', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Row(
              children: [
                _buildSaveAsChip('Home', Icons.home),
                const SizedBox(width: 10),
                _buildSaveAsChip('Shop', Icons.store),
                const SizedBox(width: 10),
                _buildSaveAsChip('Other', Icons.favorite),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const VehicleSelectionScreen()));
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Confirm and Proceed', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveAsChip(String label, IconData icon) {
    bool isSelected = _saveAs == label;
    return ChoiceChip(
      label: Row(
        children: [
          Icon(icon, size: 18, color: isSelected ? Colors.white : Colors.grey[700]),
          const SizedBox(width: 5),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _saveAs = selected ? label : '';
        });
      },
      selectedColor: Colors.blue,
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87),
    );
  }
}

// ================= C-07: VEHICLE SELECTION SCREEN =================
class V
