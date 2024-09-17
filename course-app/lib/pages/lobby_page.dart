import 'package:course/cache/cache.dart';
import 'package:flutter/material.dart';

class LobbyPage extends StatelessWidget {
  Future<void> _logout(BuildContext context) async {
    AppCache.cleanToken();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    final double buttonHeight =
        MediaQuery.of(context).size.height / 4; // 將 GridView 高度平分為四份

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lobby'),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              _logout(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Icon(Icons.logout),
                  SizedBox(width: 8.0),
                  Text('登出', style: TextStyle(fontSize: 16.0)),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: buttonHeight,
              child: _buildButton(context, index),
            );
          },
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, int index) {
    List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple
    ];
    List<String> texts = ['建立課程', '查詢課程', '查詢講師', '我選的課', '我開的課'];

    return ElevatedButton(
      onPressed: () => pushRoute(context, index),
      style: ElevatedButton.styleFrom(
        backgroundColor: colors[index],
        padding: const EdgeInsets.all(16.0),
      ),
      child: Text(
        texts[index],
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  void pushRoute(BuildContext context, int pageIndex) {
    switch (pageIndex) {
      case 0:
        Navigator.pushNamed(context, '/create-course');
        break;
      case 1:
        Navigator.pushNamed(context, '/search-course');
        break;
      case 2:
        Navigator.pushNamed(context, '/teachers');
        break;
      case 3:
        Navigator.pushNamed(context, '/enrolled-courses');
        break;
      case 4:
        Navigator.pushNamed(context, '/my-courses');
        break;
      default:
        print('Nothing');
        break;
    }
  }
}
