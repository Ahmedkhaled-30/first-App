import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              maxLength: 8,
              decoration: InputDecoration(labelText: 'Password (8 digits)'),
            ),
            ElevatedButton(
              onPressed: () {
                // Check if the password is 8 digits (you can add more validation as needed)
                if (passwordController.text.length == 8) {
                  // Navigate to the home page and pass the username
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen(username: usernameController.text)),
                  );
                } else {
                  // Show an error message if the password is not 8 digits
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Password must be 8 digits.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(primary: Colors.black),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the password recovery page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                );
              },
              style: TextButton.styleFrom(primary: Colors.black),
              child: Text('Forgot Password?', style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the sign-up page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              style: TextButton.styleFrom(primary: Colors.black),
              child: Text('No account? Sign up', style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? 'Home' : _selectedIndex == 1 ? 'Categories' : 'Settings',
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Logout', style: TextStyle(color: Colors.green)),
              onTap: () {
                // Implement the logout functionality and clear user data
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the home screen, ${widget.username}!',
              style: TextStyle(color: Colors.green),
            ),
            if (_selectedIndex == 0) // Home Screen
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    // تحديد سعر العنصر ليكون على الأقل 1
                    int price = (index + 1) * 10;
                    return ListTile(
                      title: Text('Item ${index + 1}', style: TextStyle(color: Colors.black)),
                      subtitle: Text(
                        'Price: \$${price > 0 ? price : 1}',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
            if (_selectedIndex == 1) // Categories Screen
              Expanded(
                child: Center(
                  child: CategoriesScreen(),
                ),
              ),
            if (_selectedIndex == 2) // Settings Screen
              Expanded(
                child: Center(
                  child: Text(
                    'Settings Screen',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.green),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category, color: Colors.green),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.green),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'Enter your email to reset your password.',
          style: TextStyle(color: Colors.green),
        ),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'Sign up page content goes here.',
          style: TextStyle(color: Colors.green),
        ),
      ),
    );
  }
}

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.black,
            child: Icon(
              Icons.abc,
              color: Colors.green,
            ),
          ),
        );
      },
    );
  }
}

    