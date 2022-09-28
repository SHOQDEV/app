
import 'package:app_artistica/database/client_model.dart';
import 'package:app_artistica/database/invoice_model.dart';
import 'package:app_artistica/database/sale_product_model.dart';
import 'package:app_artistica/database/selected_product_model.dart';
import 'dart:io';
export 'package:app_artistica/database/sale_product_model.dart';
export 'package:app_artistica/database/client_model.dart';
export 'package:app_artistica/database/invoice_model.dart';
export 'package:app_artistica/database/selected_product_model.dart';


import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

class DBProvider{

  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();


  Future<Database> get database async {
    if(_database!=null) return _database!;


    _database = await initDB();
    return _database!;

  }

  Future<Database> initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'artisticabd.db');
    return await openDatabase(
      path,
      version:1,
      onOpen: (db){ },
      onCreate: (Database db, int version) async {
          await db.execute('''
            CREATE TABLE clients_ff(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              email TEXT,
              numberDocument INTEGER,
              typeDocument INTEGER,
              numberContact INTEGER
            )
          ''');
          await db.execute('''
            CREATE TABLE invoices_ff(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              clientId INTEGER,
              codeTypePayment TEXT,
              numberTarjet INTEGER,
              codeCoin TEXT,
              exchangeRate DOUBLE,
              date DATETIME,
              countOverrideOrReverse INTEGER,
              reasonOverrideCode INTEGER,
              fileInvoice TEXT,
              totalAmount DOUBLE,
              totalAmountSubjectToIva DOUBLE,
              totalAmountCurrency DOUBLE,
              amountGiftCard DOUBLE,
              additionalDiscount DOUBLE,
              address TEXT,
              telephone TEXT,
              municipality TEXT,
              invoiceNumber TEXT,
              cuf TEXT,
              legend TEXT,
              urlQr TEXT,
              publicity TEXT,
              companyName TEXT
            )
          ''');
          await db.execute('''
            CREATE TABLE selectedProducts_ff(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              productId TEXT,
              discount DOUBLE,
              typeDiscount TEXT,
              quantity INTEGER,
              price DOUBLE
            )
          ''');
          await db.execute('''
            CREATE TABLE saleProducts_ff(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              productId INTEGER,
              invoiceId INTEGER,
              discount DOUBLE,
              typeDiscount TEXT,
              quantity INTEGER,
              price DOUBLE
            )
          ''');
      }
    );
  }
  //GUARDAR INFO
  Future<int> newSoldProductsModel( SoldProductsModel data )async{
    final db = await database;
    final res = await db.insert('saleProducts_ff',data.toJson());
    return res;
  }
  Future<int> newSelectedProductsModel( SelectedProductsModel newData )async{
    final db = await database;
    final res = await db.insert('selectedProducts_ff',newData.toJson());
    return res;
  }
  Future<int> newClientsModel( ClientsModel newData )async{
    final db = await database;
    final res = await db.insert('clients_ff',newData.toJson());
    return res;
  }
  Future<int> newInvoicesModel( InvoicesModel newData )async{
    final db = await database;
    final res = await db.insert('invoices_ff',newData.toJson());
    return res;
  }

  //OBTENER DATOS SEGUN EL ID
  Future<SoldProductsModel> getSoldProductsModelById(int id) async{
    final db = await database;
    final res = await db.query('saleProducts_ff', where: 'id = ?', whereArgs: [id]);
    return SoldProductsModel.fromJson( res.first);
  }

  Future<SelectedProductsModel?> getALLSelectedProductsModelByproductId(String categoryId) async{
    final db = await database;
    final res = await db.query('selectedProducts_ff', where: 'productId = ?', whereArgs: [categoryId]);
    return res.isNotEmpty? SelectedProductsModel.fromJson( res.first ) : null;
    // return res.isNotEmpty
    //       ? res.map((c)=>SelectedProductsModel.fromJson(c)).toList()
    //       :[];
  }

  Future<SelectedProductsModel> getSelectedProductsModelById(int id) async{
    final db = await database;
    final res = await db.query('selectedProducts_ff', where: 'id = ?', whereArgs: [id]);
    
    return SelectedProductsModel.fromJson( res.first);
  }
  Future<SelectedProductsModel> getSelectedProductsModelByIdProduct(int productId) async{
    final db = await database;
    final res = await db.query('selectedProducts_ff', where: 'productId = ? ', whereArgs: [productId]);
    return SelectedProductsModel.fromJson(res.first);
  }
  Future<ClientsModel> getClientsModelById(int id) async{
    final db = await database;
    final res = await db.query('clients_ff', where: 'id = ?', whereArgs: [id]);
    
    return ClientsModel.fromJson( res.first);
  }
  Future<InvoicesModel> getInvoicesModelById(int id) async{
    final db = await database;
    final res = await db.query('invoices_ff', where: 'id = ?', whereArgs: [id]);
    
    return InvoicesModel.fromJson( res.first);
  }
  //OBTENER TODOS LOS DATOS
  Future<List<SoldProductsModel>> getALLSoldProductsModel() async{
    final db = await database;
    final res = await db.query('saleProducts_ff');
    return res.isNotEmpty
          ? res.map((c)=>SoldProductsModel.fromJson(c)).toList()
          :[];
  }

  Future<List<SelectedProductsModel>> getALLSelectedProductsModel() async{
    final db = await database;
    final res = await db.query('selectedProducts_ff');
    return res.isNotEmpty
          ? res.map((c)=>SelectedProductsModel.fromJson(c)).toList()
          :[];
  }
  Future<List<ClientsModel>> getALLClientsModel() async{
    final db = await database;
    final res = await db.query('clients_ff');
    return res.isNotEmpty
          ? res.map((c)=>ClientsModel.fromJson(c)).toList()
          :[];
  }
  Future<List<InvoicesModel>> getALLInvoicesModel() async{
    final db = await database;
    final res = await db.query('invoices_ff');
    return res.isNotEmpty
          ? res.map((c)=>InvoicesModel.fromJson(c)).toList()
          :[];
  }

  //ACTUALIZAR DATOS SEGUN EL ID
  Future<int> updateClient(ClientsModel data)async{
    final db = await database;
    final res = await db.update('clients_ff', data.toJson(),where: 'id = ?',whereArgs:[ data.id ]);
    return res;
  }

  Future<int> updateSelectProduct(SelectedProductsModel data)async{
    final db = await database;
    final res = await db.update('selectedProducts_ff', data.toJson(),where: 'id = ?',whereArgs:[ data.id ]);
    return res;
  }

  Future<int> updateInvoice(InvoicesModel data)async{
    final db = await database;
    final res = await db.update('invoices_ff', data.toJson(),where: 'id = ?',whereArgs:[ data.id ]);
    return res;
  }
  
  Future<int> deleteSelectProductById(int id)async{
    final db = await database;
    final res = await db.delete('selectedProducts_ff',where: 'id = ?',whereArgs: [id]);
    return res;
  }
  Future<int> deleteClientById(int id)async{
    final db = await database;
    final res = await db.delete('clients_ff',where: 'id = ?', whereArgs:[id]);
    return res;
  }
    Future<int> deleteALLclients()async{
    final db = await database;
    final res = await db.rawDelete('''
        DELETE FROM clients_ff
    ''');
    return res;
  }
    Future<int> deleteALLinvoices()async{
    final db = await database;
    final res = await db.rawDelete('''
        DELETE FROM invoices_ff
    ''');
    return res;
  }

    Future<int> deleteALLproducts()async{
    final db = await database;
    final res = await db.rawDelete('''
        DELETE FROM products_ff
    ''');
    return res;
  }
    Future<int> deleteALLSelectProduct()async{
    final db = await database;
    final res = await db.rawDelete('''
        DELETE FROM selectedProducts_ff
    ''');
    return res;
  }
    Future<int> deleteALLsaleProducts()async{
    final db = await database;
    final res = await db.rawDelete('''
        DELETE FROM saleProducts_ff
    ''');
    return res;
  }
    Future<int> deleteALL()async{
    final db = await database;
    await db.execute('''
        DROP TABLE selectedProducts_ff
    ''');
    await db.rawDelete('''
        DELETE FROM clients_ff WHERE id NOT IN(1,2,3)
    ''');
    await db.rawDelete('''
        DELETE FROM invoices_ff
    ''');
    await db.rawDelete('''
        DELETE FROM products_ff
    ''');
    await db.execute('''
      CREATE TABLE selectedProducts_ff(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId INTEGER,
        discount DOUBLE,
        typeDiscount TEXT,
        quantity INTEGER,
        price DOUBLE,
        serie TEXT,
        imei TEXT,
        state INTEGER
      )
    ''');
    await db.rawDelete('''
        DELETE FROM saleProducts_ff
    ''');
    return 1;
  }
}