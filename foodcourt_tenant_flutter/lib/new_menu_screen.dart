import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class NewMenuScreen extends StatefulWidget{
  NewMenuScreen({Key? key, this.tenantId});
  final tenantId;

  @override
  State<NewMenuScreen> createState() => _NewMenuScreenState();
}

class _NewMenuScreenState extends State<NewMenuScreen> {
  final String rawApi = 'http://192.168.0.22:8000/api/';
  final String urlPostNewFood = 'http://192.168.0.22:8000/api/create-food';
  // final String rawApi = 'http://192.168.1.19:8000/api/';
  // final String urlPostNewFood = 'http://192.168.1.19:8000/api/create-food';

  Future<Map<String, dynamic>?> postNewFood(String name, String description, int price, String image) async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };
    final mimeTypeData = lookupMimeType(image, headerBytes: [0xFF, 0xD8])?.split('/');
    final foodUploadRequest = http.MultipartRequest('POST', Uri.parse(urlPostNewFood));
    final file = await http.MultipartFile.fromPath('img_path', image, contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));
    foodUploadRequest.fields.addAll({
      'tenant_id' : widget.tenantId.toString(),
      'name': name,
      'description' : description,
      'price' : price.toString(),
    });
    foodUploadRequest.files.add(file);
    try{
      final streamedResponse = await foodUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200){
        return null;
      }
      Navigator.pop(context, false);
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } catch(e){
      print(e);
      return null;
    }

  }

  // File? image;
  String image = "";

  Future getImage() async{
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked = (await picker.pickImage(source: ImageSource.gallery));
    setState(() {
      image = imagePicked!.path;
    });
  }

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Menu'),
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, right: 10, left: 10, bottom: 10),
          child: Column(
            children: [
              const Text("Add New Menu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 30,),
              TextField(
                controller: _controllerName,
                decoration: const InputDecoration(
                    hintText: "Masukan nama makanan...",
                    labelText: "Name",
                    icon: Icon(Icons.fastfood)),
              ),
              TextField(
                controller: _controllerDescription,
                decoration: const InputDecoration(
                    hintText: "Masukan deskripsi makanan...",
                    labelText: "Description",
                    icon: Icon(Icons.edit)),
              ),
              TextField(
                controller: _controllerPrice,
                decoration: const InputDecoration(
                    hintText: "Masukan harga makanan...",
                    labelText: "Price",
                    icon: Icon(Icons.monetization_on_rounded)),
              ),
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Icon(Icons.image, color: Colors.grey,),
                    SizedBox(width: 10,),
                    (image == "")?
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade100),
                      ),
                      child: Text('Choose Image', style: TextStyle(color: Colors.black54),),
                      onPressed: () async {
                        await getImage();
                      },
                    ) :
                        Container(
                          width: 300,
                          child: Image.file(File(image)),
                        ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                  onPressed: (){
                    postNewFood(_controllerName.text, _controllerDescription.text, int.parse(_controllerPrice.text), image);
                  },
                  child: Text("Submit")
              )
            ],
          ),
        ),
      )
    );
  }
}