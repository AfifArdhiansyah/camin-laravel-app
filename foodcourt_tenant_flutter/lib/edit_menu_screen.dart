import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class EditMenuScreen extends StatefulWidget{
  EditMenuScreen({Key? key, this.tenantId, this.food});
  final tenantId;
  final food;

  @override
  State<EditMenuScreen> createState() => _EditMenuScreenState();
}

class _EditMenuScreenState extends State<EditMenuScreen> {
  final String rawApi = 'http://192.168.0.22:8000/api/';
  final String urlPostEditFood = 'http://192.168.0.22:8000/api/edit-food';
  // final String rawApi = 'http://192.168.1.19:8000/api/';
  // final String urlPostNewFood = 'http://192.168.1.19:8000/api/create-food';

  Future<Map<String, dynamic>?> postNewFood(String name, String description, int price, String image) async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };
    final mimeTypeData = lookupMimeType(image, headerBytes: [0xFF, 0xD8])?.split('/');
    final foodUploadRequest = http.MultipartRequest('POST', Uri.parse(urlPostEditFood + '/' + widget.food['id'].toString()));
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
      Navigator.pop(context, widget.food);
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

  late final TextEditingController _controllerName;
  late final TextEditingController _controllerDescription;
  late final TextEditingController _controllerPrice;
  @override
  void initState() {
    _controllerName = TextEditingController()..text = widget.food['name'];
    _controllerDescription = TextEditingController()..text = widget.food['description'];
    _controllerPrice = TextEditingController()..text = widget.food['price'].toString();
    super.initState();
  }

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
                TextFormField(
                  // initialValue: widget.food['name'],
                  controller: _controllerName,
                  decoration: const InputDecoration(
                      hintText: "Masukan nama makanan...",
                      labelText: "Name",
                      icon: Icon(Icons.fastfood)),
                ),
                TextFormField(
                  // initialValue: widget.food['description'],
                  controller: _controllerDescription,
                  decoration: const InputDecoration(
                      hintText: "Masukan deskripsi makanan...",
                      labelText: "Description",
                      icon: Icon(Icons.edit)),
                ),
                TextFormField(
                  // initialValue: widget.food['price'].toString(),
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