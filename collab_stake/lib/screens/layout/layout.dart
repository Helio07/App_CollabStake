import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  final Widget? child;
  final int selectedIndex;

  const Layout({super.key, this.child, this.selectedIndex = 0});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late int _selectedIndex ;

   @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFEBF2FA),
        title: Text(
          'CollabStake',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Ajuda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Conta',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/deshboard');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/deshboard/ajuda');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/deshboard/conta');
              break;
          }
        },
        backgroundColor: const Color(0xFFEBF2FA),
        selectedItemColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
