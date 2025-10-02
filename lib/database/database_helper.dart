import 'dart:io';
import 'package:first_ui/login/model/users.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _db;

  static Future<Database> database() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    if (_db != null) return _db!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'coffee_app.db');
    print(path);
    _db = await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT,
            price TEXT,
            deliveryFee TEXT,
            imagePath TEXT,
            category TEXT,
            size TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE cart(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId INTEGER,
            quantity INTEGER,
            size TEXT,
            username TEXT,
            FOREIGN KEY(productId) REFERENCES products(id) ON DELETE CASCADE
          )
        ''');

        await db.execute('''
          CREATE TABLE bills(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            createdAt TEXT,
            total REAL,
            username TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE bill_details(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            billId INTEGER,
            productId INTEGER,
            quantity INTEGER,
            price REAL,
            FOREIGN KEY(billId) REFERENCES bills(id) ON DELETE CASCADE,
            FOREIGN KEY(productId) REFERENCES products(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE users(
            usrId INTEGER PRIMARY KEY AUTOINCREMENT,
            fullname TEXT,
            email TEXT,
            usrName TEXT UNIQUE,
            password TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE notifications(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            billId INTEGER,
            message TEXT,
            createdAt TEXT,
            username TEXT,
            usrId INTEGER,
            FOREIGN KEY(usrId) REFERENCES users(ursId) ON DELETE CASCADE
          )
        ''');

        await insertInitialProducts(db);
      },
    );
    return _db!;
  }

  static Future<int> insert(String table, Map<String, Object?> data) async {
    final db = await DatabaseHelper.database();
    return db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getAll(String table) async {
    final db = await DatabaseHelper.database();
    return db.query(table);
  }

  static Future<int> delete(String table, int id) async {
    final db = await DatabaseHelper.database();
    return db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> update(
      String table, Map<String, Object?> data, int id) async {
    final db = await DatabaseHelper.database();
    return db.update(table, data, where: 'usrId = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> queryWhere(
      String table, String where, List<Object?> whereArgs) async {
    final db = await DatabaseHelper.database();
    return db.query(table, where: where, whereArgs: whereArgs);
  }

  Future<bool> authenticate(Users usr) async {
    final db = await DatabaseHelper.database();
    var result = await db.query(
      "users",
      where: "usrName = ? AND password = ?",
      whereArgs: [usr.usrName, usr.password],
    );
    return result.isNotEmpty;
  }

  Future<int> updateUser(Users usr) async {
    final db = await DatabaseHelper.database();
    return await db.update(
      "users",
      usr.toMap(),
      where: "usrId = ?",
      whereArgs: [usr.usrId],
    );
  }

  Future<int> createUser(Users usr) async {
    final db = await DatabaseHelper.database();
    return await db.insert("users", usr.toMap());
  }

  Future<Users?> getUserByUsername(String username) async {
    Database db = await DatabaseHelper.database();
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'usrname = ?',
      whereArgs: [username],
    );
    if (maps.isNotEmpty) {
      return Users.fromMap(maps.first);
    }
    return null;
  }

  static Future<void> insertInitialProducts(Database db) async {
    final products = [
      {
        "id": 1,
        "name": "Dalgona Coffee",
        "description": "Whipped creamy coffee",
        "price": "US \$15.00",
        "deliveryFee": "US \$2",
        "imagePath": "assets/images/Dalgona_Coffee.jpeg",
        "category": "Espresso",
        "size": "M"
      },
      {
        "id": 2,
        "name": "Cappuccino đá",
        "description": "Delicious creamy iced coffee",
        "price": "US \$20.00",
        "deliveryFee": "US \$1",
        "imagePath": "assets/images/Iced_Cappuccino.jpeg",
        "category": "Cappuccino",
        "size": "M"
      },
      {
        "id": 3,
        "name": "Cappuccino nóng",
        "description": "Delicious hot creamy coffee",
        "price": "US \$20.00",
        "deliveryFee": "US \$1",
        "imagePath": "assets/images/Hot_Cappuccino.jpeg",
        "category": "Cappuccino",
        "size": "M"
      },
      {
        "id": 4,
        "name": "Latte đá",
        "description": "Smooth espresso with chilled milk",
        "price": "US \$18.00",
        "deliveryFee": "US \$3",
        "imagePath": "assets/images/Iced_Latte.jpeg",
        "category": "Latte",
        "size": "M"
      },
      {
        "id": 5,
        "name": "Latte nóng",
        "description": "Warm and creamy coffee",
        "price": "US \$18.00",
        "deliveryFee": "US \$3",
        "imagePath": "assets/images/Hot_Latte.jpeg",
        "category": "Latte",
        "size": "M"
      },
      {
        "id": 6,
        "name": "Espresso đá",
        "description": "Strong and refreshing",
        "price": "US \$18.00",
        "deliveryFee": "US \$3",
        "imagePath": "assets/images/Iced_Espresso.jpeg",
        "category": "Espresso",
        "size": "M"
      },
      {
        "id": 7,
        "name": "Espresso nóng",
        "description": "Pure concentrated espresso flavor",
        "price": "US \$18.00",
        "deliveryFee": "US \$3",
        "imagePath": "assets/images/Hot_Latte.jpeg",
        "category": "Espresso",
        "size": "M"
      },
      {
        "id": 8,
        "name": "Cà phê đen",
        "description": "Pure brewed coffee, no milk",
        "price": "US \$10.00",
        "deliveryFee": "US \$1",
        "imagePath": "assets/images/Black_Coffee.jpeg",
        "category": "Espresso",
        "size": "M"
      },
      {
        "id": 9,
        "name": "Nâu đá",
        "description": "Chilled, creamy, and energizing",
        "price": "US \$22.00",
        "deliveryFee": "US \$3",
        "imagePath": "assets/images/Iced_Milk_Coffee.jpeg",
        "category": "Vietnamese Coffee",
        "size": "M"
      },
      {
        "id": 10,
        "name": "Nâu nóng",
        "description": "Traditional style hot coffee",
        "price": "US \$22.00",
        "deliveryFee": "US \$2",
        "imagePath": "assets/images/Hot_Milk_Coffee.jpeg",
        "category": "Vietnamese Coffee",
        "size": "M"
      },
      {
        "id": 11,
        "name": "Cà phê sữa đá",
        "description": "Creamy and light style drink",
        "price": "US \$20.00",
        "deliveryFee": "US \$1",
        "imagePath": "assets/images/Iced_Milk_with_a_Splash_of_Coffee.jpeg",
        "category": "Latte",
        "size": "M"
      },
      {
        "id": 12,
        "name": "Cà phê sữa nóng",
        "description": "Creamy, smooth, and lightly caffeinated",
        "price": "US \$20.00",
        "deliveryFee": "US \$1",
        "imagePath": "assets/images/Hot_Milk_with_a_Splash_of_Coffee.jpeg",
        "category": "Latte",
        "size": "M"
      },
      {
        "id": 13,
        "name": "Americano đá",
        "description": "Bold, smooth, and refreshing",
        "price": "US \$17.00",
        "deliveryFee": "US \$3",
        "imagePath": "assets/images/Iced_Americano.jpeg",
        "category": "Americano",
        "size": "M"
      },
      {
        "id": 14,
        "name": "Americano nóng",
        "description": "Espresso diluted with hot water",
        "price": "US \$17.00",
        "deliveryFee": "US \$3",
        "imagePath": "assets/images/Hot_Americano.jpeg",
        "category": "Americano",
        "size": "M"
      },
      {
        "id": 15,
        "name": "Caramel Macchiato đá",
        "description": "Sweet, creamy, and refreshing",
        "price": "US \$16.00",
        "deliveryFee": "US \$2",
        "imagePath": "assets/images/Iced_Caramel_Macchiato.jpeg",
        "category": "Latte",
        "size": "M"
      },
      {
        "id": 16,
        "name": "Caramel Macchiato nóng",
        "description": "Warm, sweet, and creamy",
        "price": "US \$16.00",
        "deliveryFee": "US \$2",
        "imagePath": "assets/images/Hot_Caramel_Macchiato.jpeg",
        "category": "Latte",
        "size": "M"
      },
      {
        "id": 17,
        "name": "Cold Brew sữa tươi",
        "description": "Chilled, mellow, and refreshing",
        "price": "US \$24.00",
        "deliveryFee": "US \$3",
        "imagePath": "assets/images/Cold_Brew_Milk_Coffee.jpeg",
        "category": "Cold Brew",
        "size": "M"
      },
      {
        "id": 18,
        "name": "Cold Brew truyền thống",
        "description": "Bold, smooth, and naturally sweet",
        "price": "US \$24.00",
        "deliveryFee": "US \$3",
        "imagePath": "assets/images/Black_Cold_Brew.jpeg",
        "category": "Cold Brew",
        "size": "M"
      },
    ];

    for (final p in products) {
      await db.insert('products', p,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<Users?> getUserById(int usrId) async {
    final db = await DatabaseHelper.database();
    final maps = await db.query(
      'users',
      where: 'usrId = ?',
      whereArgs: [usrId],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return Users.fromMap(maps.first);
    }
    return null;
  }
}
