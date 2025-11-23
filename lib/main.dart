import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _openLink(String url, BuildContext context) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Could not open $url")),
    );
  }
}



void main() => runApp(MyProfileApp());

class MyProfileApp extends StatefulWidget {
  const MyProfileApp({super.key});

  @override
  _MyProfileAppState createState() {
    return _MyProfileAppState();
  }
}

class _MyProfileAppState extends State<MyProfileApp> {
  bool _isDark = false;

  final Map<String, dynamic> user = {
    'name': 'Muhammad Ali',
    'profession': 'AI Engineer',
    'bio':
    'A passionate Flutter developer who loves building clean and responsive UIs. Always learning and exploring new technologies.',
    'email': 'mail.to.ali.56@gmail.com',
    'phone': '+92 3554356014',
    'location': 'Yasin, Gilgit, Pakistan',
    'skills': ['Python (AI & ML Development)','Machine Learning Algorithms','Dart', 'Flutter', 'Firebase', 'Git & GitHub', 'NLP (Large Language Models)'],
    'education': [
      'BS Software Engineering \n\t\t Karakuram International University Gilgit',
      'Intermediate (ICS) \n\t\t Federal Board Of Intermediate and Secondary Education',
      'Matriculation (Science) \n\t\t Karakuram International University Gilgit'

    ],
    'hobbies': ['Building AI mini-projects','Reading AI research articles','Basketball', 'Reading', 'Photography']
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Profile App',
      debugShowCheckedModeBanner: false,
      theme: _isDark
          ? ThemeData.dark()
          : ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: Builder(
        // FIXED: Builder gives a valid Navigator context
        builder: (context) => WelcomeScreen(
          onViewProfile: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfileScreen(
                  user: user,
                  onToggleTheme: () => setState(() => _isDark = !_isDark),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//////////////////////////////////////
//      WELCOME SCREEN
//////////////////////////////////////

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onViewProfile;
  const WelcomeScreen({super.key, required this.onViewProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade700, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Spacer(),
              Icon(Icons.account_circle, size: 120, color: Colors.white70),
              SizedBox(height: 20),
              Text(
                'Welcome to My Profile',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  'A simple Flutter app to view profile and about me.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onViewProfile,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: Text('View Profile', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////
//         PROFILE SCREEN
//////////////////////////////////////

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> user;
  final VoidCallback onToggleTheme;

  const ProfileScreen({super.key, required this.user, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(icon: Icon(Icons.brightness_6), onPressed: onToggleTheme)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.info_outline),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AboutPage(user: user),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 56,
              backgroundImage: AssetImage("assets/images/pp.jpg"),
            ),
            SizedBox(height: 12),
            Text(user['name'],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text(user['profession'], style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),

            /// BIO
            Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(user['bio'], textAlign: TextAlign.center),
              ),
            ),

            SizedBox(height: 12),

            /// CONTACT CARD
            Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text("Email"),
                      subtitle: Text(user['email']),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text("Phone"),
                      subtitle: Text(user['phone']),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text("Location"),
                      subtitle: Text(user['location']),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 14),

            /// SOCIAL ICONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.link),
                  onPressed: () => _openLink("https://www.linkedin.com/in/muhammad-ali-350a1636a/",context),
                ),
                IconButton(
                  icon: Icon(Icons.code),
                  onPressed: () => _openLink("https://github.com/Muhammad-Ali-56",context),
                ),
                IconButton(
                  icon: Icon(Icons.chat),
                  onPressed: () => _openLink("mailto:mail.to.ali.56@gmail.com",context),
                ),
              ],
            ),

            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////
//         ABOUT PAGE
//////////////////////////////////////

class AboutPage extends StatelessWidget {
  final Map<String, dynamic> user;
  const AboutPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final skills = List<String>.from(user['skills']);
    final edu = List<String>.from(user['education']);
    final hobbies = List<String>.from(user['hobbies']);

    return Scaffold(
      appBar: AppBar(title: Text("About Me")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text("Education",
              style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          ...edu.map((e) => Card(child: ListTile(title: Text(e)))),

          SizedBox(height: 12),
          Text("Skills",
              style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((s) => Chip(label: Text(s))).toList(),
          ),

          SizedBox(height: 12),
          Text("Hobbies",
              style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...hobbies
              .map((h) =>
              ListTile(leading: Icon(Icons.star_border), title: Text(h)))
              ,

          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
            label: Text("Back to Profile"),
          ),
        ],
      ),
    );
  }
}
