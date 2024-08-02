import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/photo_viewmodel.dart';

class PhotoListView extends StatefulWidget {
  const PhotoListView({super.key});

  @override
  PhotoListViewState createState() => PhotoListViewState();
}

class PhotoListViewState extends State<PhotoListView> {
  final TextEditingController searchController = TextEditingController();
  bool showSearchHistory = false;
  late String selectedImage;
  List<String> searchHistory = [];
  
  void showImageModal(String imageUrl, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              // Contenedor principal con Material Design
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 40.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Imagen
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        width: 400,
                        height: 600,
                      ),
                    ),
                    // Título de la imagen
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Imágenes'),
      ),
      body: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Buscar imágenes',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search, color: Colors.grey[700]),
                  onPressed: () {
                    final query = searchController.text;
                    if (query.isNotEmpty) {
                      setState(() {
                        searchHistory.add(query);
                      });
                      Provider.of<PhotoViewModel>(context, listen: false)
                          .fetchPhotos(query);
                    }
                  },
                ),
              ],
            ),
          ),
          // Show/Hide Historial
          ElevatedButton(
            onPressed: () {
              setState(() {
                showSearchHistory = !showSearchHistory;
              });
            },
            child: Icon(
              showSearchHistory ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey[700],
            ),
          ),
          // Buscar en el historial
          if (showSearchHistory)
            Expanded(
              child: ListView.builder(
                itemCount: searchHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(searchHistory[index]),
                    onTap: () {
                      searchController.text = searchHistory[index];
                      Provider.of<PhotoViewModel>(context, listen: false)
                          .fetchPhotos(searchHistory[index]);
                    },
                  );
                },
              ),
            ),
          // Image Grid
          Expanded(
            child: Consumer<PhotoViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.imagesList.isEmpty) {
                  return const Center(child: Text('No images found'));
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //Columnas de imágenes por mostrar
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.75, // Aspect ratio ajustado para incluir texto
                  ),
                  itemCount: viewModel.imagesList.length,
                  itemBuilder: (context, index) {
                    final photo = viewModel.imagesList[index];
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          showImageModal(photo.imageUrl, photo.title); // Mostrar la imagen en un modal
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  photo.imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                photo.title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}