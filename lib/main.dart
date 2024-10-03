import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reminder/user_ui.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Picture Palette',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Picture Palette'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  List<File?> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    _loadSavedImages();
  }

  Future<void> _loadSavedImages() async {
    final directory = await getApplicationDocumentsDirectory();
    int index = 0;
    List<File?> images = [];
    while (true) {
      final imagePath = '${directory.path}/image_$index.jpg';
      final file = File(imagePath);
      if (await file.exists()) {
        images.add(file);
        index++;
      } else {
        break;
      }
    }
    setState(() {
      _selectedImages = images;
    });
  }

  Future<void> _pickAndSaveImage(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/image_$index.jpg';

      // Delete and replace the old image file
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
      }
      await File(pickedFile.path).copy(imagePath);

      setState(() {
        _selectedImages[index] = File(imagePath);
      });
    }
  }

  Future<void> _createNewPage() async {
    setState(() {
      _selectedImages.add(null);
    });
    _pageController.animateToPage(
      _selectedImages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _deleteCurrentPage() async {
    if (_selectedImages.isEmpty) return;

    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/image_$_currentPage.jpg';

    // Delete the file
    final file = File(imagePath);
    if (await file.exists()) {
      await file.delete();
    }

    setState(() {
      _selectedImages.removeAt(_currentPage);
      if (_currentPage > 0 && _currentPage == _selectedImages.length) {
        _currentPage--;
      }
    });

    // Renumber remaining files
    for (int i = _currentPage; i < _selectedImages.length; i++) {
      final oldPath = '${directory.path}/image_${i + 1}.jpg';
      final newPath = '${directory.path}/image_$i.jpg';
      final oldFile = File(oldPath);
      if (await oldFile.exists()) {
        await oldFile.rename(newPath);
      }
    }

    _pageController.jumpToPage(_currentPage);
  }

  Future<void> _changeImage() async {
    await _pickAndSaveImage(_currentPage);

    // Clear any cached images to force a UI refresh
    imageCache.clear();
    imageCache.clearLiveImages();
  }

  void _exitApp() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Create new page'),
                onTap: _createNewPage,
              ),
              PopupMenuItem(
                child: const Text('Delete this page'),
                onTap: _deleteCurrentPage,
              ),
              PopupMenuItem(
                child: const Text('Change Image'),
                onTap: _changeImage,
              ),
              PopupMenuItem(
                child: const Text('Exit'),
                onTap: _exitApp,
              ),
            ],
          ),
        ],
      ),
      body: _selectedImages.isEmpty ? _buildInitialDesign() :  // Display custom design if no images
      Column(
        children: [
          Expanded(
            child:  PageView.builder(
              controller: _pageController,
              itemCount: _selectedImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Center(
                  key: ValueKey(_selectedImages[index]?.path ?? 'empty_$index'), // Unique key to force rebuild
                  child: _selectedImages[index] != null
                      ? Image.file(
                    _selectedImages[index]!,
                    key: ValueKey(DateTime.now().millisecondsSinceEpoch), // Unique key to force image reload
                  )
                      : ElevatedButton(
                    onPressed: () => _pickAndSaveImage(index),
                    child: const Text('Add Image'),
                  ),
                );
              },
            ),
          ),
          // Checking if there is no image, then remove the navigate buttons
          _selectedImages.isEmpty ? SizedBox() : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _currentPage > 0
                        ? () => _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    )
                        : null,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Text('Page ${_currentPage + 1}/${_selectedImages.length}'),
                  IconButton(
                    onPressed: _currentPage < _selectedImages.length - 1
                        ? () => _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    )
                        : null,
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
            ],

          ),

        ],
      ),
    );
  }
}


Widget _buildInitialDesign() {
  return UserUi();
}
