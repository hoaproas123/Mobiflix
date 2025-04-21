import 'package:mobi_phim/models/user_account_model.dart';
import 'package:mobi_phim/models/user_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DbMongoService {
  final String username='hoaproas1';
  final String password='0707622862a';
  final String cluster_url='@cluster0.5lzij2k.mongodb.net';
  final String db_name='mobiflix';

  void connectDB() async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection('love_movie');
    var documents = await collection.find().toList();

    for (var doc in documents) {
      print(doc);
    }

    await db.close();
  }

  Future<void> getAll() async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection('user');
    var documents = await collection.find().toList();

    for (var doc in documents) {
      print(doc);
    }
    await db.close();
  }
  Future<bool> getUser(String _username,String _password) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection('user');
    var user = await collection.findOne(where.eq('username', _username).eq('password', _password));
    if(user!=null)
    {
        return true;
    }
    return false;
  }
  Future<bool> isExistUser(String _username) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection('user');
    var user = await collection.findOne(where.eq('username', _username));
    if(user!=null)
    {
      return true;
    }
    return false;
  }

  Future<void> addUser(UserAccountModel newUser) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection('user');
    await collection.insert(newUser.toMap());

    print("User added!");
    await db.close();
  }
  Future<void> addMovie(Map<String, dynamic> newMovie) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection('user');
    await collection.insert(newMovie);

    print("Movie added!");
    await db.close();
  }
  Future<void> deleteMovie(String id) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection('user');
    await collection.remove(where.id(ObjectId.parse(id)));

    print("Movie deleted!");
    await db.close();
  }
  Future<void> updateMovie(String id, Map<String, dynamic> updates) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection('user');
    await collection.update(
        where.id(ObjectId.parse(id)),
        {
          r'$set': updates
        }
    );

    print("Movie updated!");
    await db.close();
  }
}