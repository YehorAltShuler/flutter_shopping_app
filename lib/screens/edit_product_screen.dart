import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/providers/product.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  static const routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlContrller = TextEditingController();
  final _imageUrlFocuseNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: '', title: ' ', description: '', price: 0, imageUrl: '');

  void _updateImageUrl() {
    if (!_imageUrlFocuseNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageUrlFocuseNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlContrller.dispose();
    _imageUrlFocuseNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imageUrlFocuseNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _saveForm() {
    _form.currentState!.validate();
    _form.currentState!.save();
    print(_editedProduct.title);
    print(_editedProduct.description);
    print(_editedProduct.price);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if (value == _editedProduct.title) {
                      return 'Please provide a value';
                    }
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: value!,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Price'),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: double.parse(value!),
                        imageUrl: _editedProduct.imageUrl);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Description'),
                  ),
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: value!,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: _imageUrlContrller.text.isEmpty
                          ? const Text('Enter a Url')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlContrller.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlContrller,
                        focusNode: _imageUrlFocuseNode,
                        onFieldSubmitted: (_) => _saveForm(),
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: value!);
                        },
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
