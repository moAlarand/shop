import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product-screen";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var _init = false;
  var _isLoading = false;
  var _editedProduct = Product(
    id: null,
    desc: '',
    imgUrl: '',
    name: '',
    price: 0,
  );

  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _descFocusNode = FocusNode();
  final FocusNode _imgUrlFocusNode = FocusNode();
  final TextEditingController _imgUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _imgUrlFocusNode.addListener(_updateImgUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_init) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _imgUrlController.text = _editedProduct.imgUrl;
      }
    }
    _init = true;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _updateImgUrl() {
    if (_imgUrlFocusNode.hasFocus &&
        _imgUrlController.text.isEmpty &&
        !_imgUrlController.text.startsWith("http")) return;
    setState(() {});
  }

  @override
  void dispose() {
    _imgUrlFocusNode.removeListener(_updateImgUrl);
    _imgUrlController.dispose();
    _imgUrlFocusNode.dispose();
    _descFocusNode.dispose();
    _priceFocusNode.dispose();
    super.dispose();
  }

  Future<void> _sumbitForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _formKey.currentState.save();
    try {
      setState(() {
        _isLoading = true;
      });
      final products = Provider.of<Products>(context, listen: false);
      if (_editedProduct.id != null) {
        await products.updateItem(_editedProduct.id, _editedProduct);
      } else {
        await products.addProduct(_editedProduct);
      }
      Navigator.pop(context);
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        builder: (_) => AlertDialog(
          title: Text("FAIL"),
          content: Text("something wrong"),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _sumbitForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                // autovalidate: true,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _editedProduct.name,
                      decoration: InputDecoration(labelText: 'name'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "required";
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        _priceFocusNode.nextFocus();
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            desc: _editedProduct.desc,
                            imgUrl: _editedProduct.imgUrl,
                            name: value,
                            price: _editedProduct.price,
                            isFav: _editedProduct.isFav);
                      },
                    ),
                    TextFormField(
                      initialValue: _editedProduct.price == 0
                          ? ''
                          : _editedProduct.price?.toString(),
                      focusNode: _priceFocusNode,
                      decoration: InputDecoration(labelText: 'price'),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (double.tryParse(value) == null) {
                          return "price unvalid";
                        }
                        if (double.parse(value) <= 0) {
                          return "price must greater than 0";
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        _descFocusNode.nextFocus();
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          desc: _editedProduct.desc,
                          imgUrl: _editedProduct.imgUrl,
                          name: _editedProduct.name,
                          price: double.parse(value),
                          isFav: _editedProduct.isFav,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _editedProduct.desc,
                      focusNode: _descFocusNode,
                      decoration: InputDecoration(labelText: 'desc'),
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.next,
                      maxLines: 3,
                      validator: (value) {
                        if (value.trim().length < 10) {
                          return "desc must greater than 10 characters";
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        _imgUrlFocusNode.nextFocus();
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          desc: value,
                          imgUrl: _editedProduct.imgUrl,
                          name: _editedProduct.name,
                          price: _editedProduct.price,
                          isFav: _editedProduct.isFav,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 8, left: 10, right: 10),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: _imgUrlController.text.isEmpty
                              ? Text(
                                  "Empty URl",
                                  textAlign: TextAlign.center,
                                )
                              : Image.network(_imgUrlController.text),
                        ),
                        Expanded(
                          child: TextFormField(
                            focusNode: _imgUrlFocusNode,
                            decoration: InputDecoration(labelText: 'image url'),
                            controller: _imgUrlController,
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value.isEmpty || !value.startsWith("http")) {
                                return "required valid img url";
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) => _sumbitForm(),
                            onSaved: (value) {
                              _editedProduct = Product(
                                id: _editedProduct.id,
                                desc: _editedProduct.desc,
                                imgUrl: value,
                                name: _editedProduct.name,
                                price: _editedProduct.price,
                                isFav: _editedProduct.isFav,
                              );
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
