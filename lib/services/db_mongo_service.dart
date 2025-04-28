import 'package:mobi_phim/models/infor_movie.dart';
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
  Future<UserAccountModel?> getUser(String _username,String _password) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();
    var collection = db.collection('user');
    var user = await collection.findOne(where.eq('username', _username).eq('password', _password));
    await db.close();
    if(user!=null)
    {
        return UserAccountModel.fromJson(user);
    }
    return null;
  }
  Future<UserAccountModel?> isExistUser(String _username) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection('user');
    var user = await collection.findOne(where.eq('username', _username));
    await db.close();
    if(user!=null)
    {
      return UserAccountModel.fromJson(user);
    }
    return null;
  }

  Future<void> addUser(UserAccountModel newUser) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection('user');
    await collection.insert(newUser.toMap());

    print("User added!");
    await db.close();
  }

  Future<ObjectId> getIdProfile(String _username) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection('profile');
    var profile = await collection.findOne(where.eq('username', _username));
    await db.close();
    return profile?['_id'] as ObjectId;
  }

  Future<bool> isExistProfile(String profile_id) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection('profile');
    var profile = await collection.findOne(where.eq('_id', profile_id));
    await db.close();
    if(profile!=null)
    {
      return true;
    }
    return false;
  }

  Future<void> addProfile(UserModel newProfile) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection('profile');
    await collection.insert(newProfile.toMap());

    print("Profile added!");
    await db.close();
  }
  Future<List<String>> getListContinueMovie(String userId) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();
    var _id;
    try{
      _id=ObjectId.fromHexString(userId);
    }
    catch(e){
      _id=userId;
    }
    var collection = db.collection('continue_movie');
    var documents = await collection.find(where.eq('profile_id',_id).sortBy('update_at',descending: true).fields(['slug_movie'])
    ).toList();
    await db.close();
    return documents.map((e) => e['slug_movie'].toString()).toList();
  }
  Future<List<String>?> getServerEpisodeContinueMovie(String userId,String slug) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();
    var _id;
    try{
      _id=ObjectId.fromHexString(userId);
    }
    catch(e){
      _id=userId;
    }
    var collection = db.collection('continue_movie');
    var documents = await collection.findOne(where.eq('profile_id',_id).eq('slug_movie', slug).fields(['server_number','episode']));
    await db.close();
    print('huhu '+documents.toString());
    if (documents != null) {
      return [
        documents['server_number'].toString(),
        documents['episode'].toString(),
      ];
    } else {
      return null;
    }
  }
  Future<void> addContinueMovie(InforMovie newMovie) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection('continue_movie');
    // Kiểm tra xem slug đã tồn tại chưa
    var existing = await collection.findOne(newMovie.findUserSlug_toMap());
    if (existing != null) {
      var _id;
      try{
        _id=ObjectId.fromHexString(newMovie.profile_id!);
      }
      catch(e){
        _id=newMovie.profile_id;
      }
      await collection.updateOne(
        where.eq('profile_id',_id).eq('slug_movie', newMovie.slug),
        modify.set('episode', newMovie.episode).set('server_number', newMovie.serverNumber).set('update_at', DateTime.now()),
      );
      print("Continue Movie updated!");
    } else {
      await collection.insert(newMovie.toMap());
      print("Continue Movie added!");
    }
    await db.close();
  }

  Future<void> removeContinueMovie(InforMovie newMovie) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();
    var collection = db.collection('continue_movie');
    var _id;
    try{
      _id=ObjectId.fromHexString(newMovie.profile_id!);
    }
    catch(e){
      _id=newMovie.profile_id;
    }
    await collection.remove(
      where.eq('profile_id',_id).eq('slug_movie', newMovie.slug),
    );
    print("Continue Movie removed!");
    await db.close();
  }
  Future<List<String>> getListFavoriteMovie(String userId) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();
    var _id;
    try{
      _id=ObjectId.fromHexString(userId);
    }
    catch(e){
      _id=userId;
    }
    var collection = db.collection('favorite_movie');
    var documents = await collection.find(where.eq('profile_id',_id).fields(['slug_movie'])
    ).toList();
    await db.close();
    return documents.map((e) => e['slug_movie'].toString()).toList();
  }
  Future<bool> isFavoriteMovie(InforMovie newMovie) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection('favorite_movie');
    var existing = await collection.findOne(newMovie.findUserSlug_toMap());
    await db.close();
    if (existing == null) {
      return false;
    }
    return true;
  }
  Future<void> addFavoriteMovie(InforMovie newMovie) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection('favorite_movie');
    // Kiểm tra xem slug đã tồn tại chưa
    var existing = await collection.findOne(newMovie.findUserSlug_toMap());
    if (existing == null) {
      await collection.insert(newMovie.toMap());
      print("Favorite Movie added!");
    }
    await db.close();
  }
  Future<void> removeFavoriteMovie(InforMovie newMovie) async {
    var db = await Db.create("mongodb+srv://$username:$password$cluster_url/$db_name?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection('favorite_movie');
    // Kiểm tra xem slug đã tồn tại chưa
    var existing = await collection.findOne(newMovie.findUserSlug_toMap());
    if (existing != null) {
      var _id;
      try{
        _id=ObjectId.fromHexString(newMovie.profile_id!);
      }
      catch(e){
        _id=newMovie.profile_id;
      }
      await collection.remove(where.eq('profile_id', _id).eq('slug_movie', newMovie.slug));
      print("Favorite Movie removed!");
    }
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