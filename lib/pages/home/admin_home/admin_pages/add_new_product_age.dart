import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coar/constants/app_constant.dart';
import 'package:coar/custom/button_custom.dart';
import 'package:coar/model/prodcut_model.dart';
import 'package:coar/pages/home/admin_home/bloc/product_cubit/product_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _actualPriceController = TextEditingController();
  final TextEditingController _offerPriceController = TextEditingController();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final productsCubit = context.read<ProductsCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Picker Box
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: _selectedImage != null
                      ? Image.file(_selectedImage!, fit: BoxFit.cover)
                      : const Center(
                          child: Text(
                            "Tap to add image",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              // Product Name
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Product Description
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Actual Price
              TextField(
                controller: _actualPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Actual Price',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Offer Price
              TextField(
                controller: _offerPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Offer Price',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 90.h),
              // Add Product Button
              ButtonCustom(
                textColor: whiteColor,
                btnColor: primaryColor,
                text: 'Add Product',
                callback: () async {
                  if (_validateInputs()) {
                    await _addProduct(productsCubit);
                  }
                },
              )
              // ElevatedButton(
              //   onPressed: () async {
              // if (_validateInputs()) {
              //   await _addProduct(productsCubit);
              // }
              //   },
              //   child: const Text("Add Product"),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Validate input fields
  bool _validateInputs() {
    if (_selectedImage == null) {
      _showSnackBar("Please select an image");
      return false;
    }
    if (_nameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _actualPriceController.text.isEmpty ||
        _offerPriceController.text.isEmpty) {
      _showSnackBar("Please fill all the fields");
      return false;
    }
    return true;
  }

  // Add product to Firestore
  Future<void> _addProduct(ProductsCubit productsCubit) async {
    final product = ProductModel(
      id: '',
      name: _nameController.text,
      description: _descriptionController.text,
      imageUrl: '',
      actualPrice: double.tryParse(_actualPriceController.text) ?? 0.0,
      offerPrice: double.tryParse(_offerPriceController.text) ?? 0.0,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );

    if (_selectedImage != null) {
      await productsCubit.addProduct(product, _selectedImage!);
      _showSnackBar("Product added successfully");
      Navigator.pop(context);
    } else {
      _showSnackBar("Failed to add product");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
