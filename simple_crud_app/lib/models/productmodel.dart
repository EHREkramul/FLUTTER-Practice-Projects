class ProductResponseModel {
  String? _status;
  List<Data>? _data;

  ProductResponseModel({String? status, List<Data>? data}) {
    if (status != null) {
      this._status = status;
    }
    if (data != null) {
      this._data = data;
    }
  }

  String? get status => _status;
  set status(String? status) => _status = status;
  List<Data>? get data => _data;
  set data(List<Data>? data) => _data = data;

  ProductResponseModel.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? _sId;
  String? _productName;
  int? _productCode;
  String? _img;
  int? _qty;
  int? _unitPrice;
  int? _totalPrice;

  Data({
    String? sId,
    String? productName,
    int? productCode,
    String? img,
    int? qty,
    int? unitPrice,
    int? totalPrice,
  }) {
    if (sId != null) {
      _sId = sId;
    }
    if (productName != null) {
      _productName = productName;
    }
    if (productCode != null) {
      _productCode = productCode;
    }
    if (img != null) {
      _img = img;
    }
    if (qty != null) {
      _qty = qty;
    }
    if (unitPrice != null) {
      _unitPrice = unitPrice;
    }
    if (totalPrice != null) {
      _totalPrice = totalPrice;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get productName => _productName;
  set productName(String? productName) => _productName = productName;
  int? get productCode => _productCode;
  set productCode(int? productCode) => _productCode = productCode;
  String? get img => _img;
  set img(String? img) => _img = img;
  int? get qty => _qty;
  set qty(int? qty) => _qty = qty;
  int? get unitPrice => _unitPrice;
  set unitPrice(int? unitPrice) => _unitPrice = unitPrice;
  int? get totalPrice => _totalPrice;
  set totalPrice(int? totalPrice) => _totalPrice = totalPrice;

  Data.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _productName = json['ProductName'];
    _productCode = json['ProductCode'];
    _img = json['Img'];
    _qty = json['Qty'];
    _unitPrice = json['UnitPrice'];
    _totalPrice = json['TotalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = _sId;
    data['ProductName'] = _productName;
    data['ProductCode'] = _productCode;
    data['Img'] = _img;
    data['Qty'] = _qty;
    data['UnitPrice'] = _unitPrice;
    data['TotalPrice'] = _totalPrice;
    return data;
  }
}
