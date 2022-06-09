import 'package:algolia/algolia.dart';
import 'package:tomato_record/data/item_model.dart';

const Algolia algolia = Algolia.init(
  applicationId: 'KX5E6GUORQ',
  apiKey: 'e48c680926d4a78a27f3bae6a1394558',
);

class AlgoliaService {
  static final AlgoliaService _algoliaService = AlgoliaService.internal();

  factory AlgoliaService() => _algoliaService;

  AlgoliaService.internal();


  Future<List<ItemModel>> queryItems(String queryStr) async {
    AlgoliaQuery query = algolia.instance.index('items').query(queryStr);

    AlgoliaQuerySnapshot algoliaSnapshot = await query.getObjects();
    List<AlgoliaObjectSnapshot> hits = algoliaSnapshot.hits;
    List<ItemModel> items = [];
    hits.forEach((element) {
      ItemModel item = ItemModel.fromAlgoliaObject(element.data, element.objectID);
      items.add(item);
    });
    return items;
  }


}