import 'dart:io';

import 'package:olx_project_parse/models/ad.dart';
import 'package:olx_project_parse/models/category.dart';
import 'package:olx_project_parse/models/user.dart';
import 'package:olx_project_parse/repositories/response_errors/parse_errors.dart';
import 'package:olx_project_parse/repositories/tables_keys/table_key.dart';
import 'package:olx_project_parse/stores/filter_store.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart' as path;

//objetos do parse so comunicam com objetos dos parse
class AdRepository {
  Future<void> save(Ad ad) async {
    try {
      //salvar imagens em formato file e recuperar em formato parseFile
      final parseImages = await saveImages(ad.images);
      final parseUser = ParseUser('', '', '')..set(keyUserId, ad.user.id);
      // parse object é o nome da tabela
      final adObject = ParseObject(keyAdTable);

      //acl é para verificação de leitura e escrita nos objetos
      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: false);
      adObject.setACL(parseAcl);

      adObject.set<String>(keyAdTitle, ad.title);
      adObject.set<String>(keyAdDescription, ad.description);
      adObject.set<bool>(keyAdHidePhone, ad.hidePhone);
      adObject.set<num>(keyAdPrice, ad.price);
      adObject.set<int>(keyAdStatus, ad.status.index);
      adObject.set<String>(keyAdCity, ad.address.city.name);
      adObject.set<String>(keyAdDistrict, ad.address.disctrict);
      adObject.set<String>(keyAdFederativeUnit, ad.address.uf.initials);
      adObject.set<String>(keyAdPostalCode, ad.address.cep);

      adObject.set<List<ParseFile>>(keyAdImages, parseImages);
      adObject.set<ParseObject>(keyAdOwner, parseUser);
      adObject.set<ParseObject>(keyAdCategory,
          ParseObject(keyCategoryTable)..set(keyCategoryId, ad.category.id));
      final response = await adObject.save();

      if (response.success) {
        //return Ad.fromParse(response.result);
        return;
      } else
        return Future.error(
          ParseErrors.getDescription(response.error.code),
        );
    } catch (e) {
      return Future.error("Falha ao salvar anúncio");
    }
  }

  Future<List<ParseFile>> saveImages(List images) async {
    final parseImages = <ParseFile>[];
    try {
      for (final image in images) {
        if (image is File) {
          //se for arquivo, fazer upload no parse Server
          final parseFile = ParseFile(image, name: path.basename(image.path));
          final response = await parseFile.save();
          if (response.success)
            //adiciona imagens a nova lista
            parseImages.add(parseFile);
          else
            Future.error(ParseErrors.getDescription(response.error.code));
        } else {
          //caso imagens estejam sendo editas e ja sao parseFiles
          final parseFile = ParseFile(null);
          parseFile.name = path.basename(image);
          parseFile.url = image;
          parseImages.add(parseFile);
        }
      }
      return parseImages;
    } catch (e) {
      return Future.error("Falha ao salvar imagens");
    }
  }

  Future<List<Ad>> getHomeAdList({
    FilterStore filter,
    String search,
    Category category,
  }) async {
    //creating a query builder
    final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyAdTable));

    //bring the object from the owner (bring objects from our interess)
    queryBuilder.includeObject([keyAdOwner, keyAdCategory]);

    //specify the number of results
    queryBuilder.setLimit(20);

    //get just the ads what are actived
    //queryBuilder.whereEqualTo(keyAdStatus, AdStatus.ACTIVE.index);

    //cases, search
    if (search != null && search.trim().isNotEmpty) {
      queryBuilder.whereContains(keyAdTitle, search, caseSensitive: false);
    }

    //category, uses pointers to concat the category with the product
    if (category != null && category.id != '*') {
      queryBuilder.whereEqualTo(
        keyAdCategory,
        (ParseObject(keyCategoryTable)..set(keyCategoryId, category.id))
            .toPointer(), //transform into a pointer
      );
      //basically, is looking like (search in category table where keyid = categoryId)
    }

    //filters
    switch (filter.orderBy) {
      case OrderBy.PRICE:
        queryBuilder.orderByAscending(keyAdPrice);
        break;
      case OrderBy.DATE:
        queryBuilder.orderByDescending(keyAdCreatedAt);
        break;
      default:
        queryBuilder.orderByAscending(keyAdTitle);
    }

    //for minimum price and maximum price
    if (filter.minPrice != null && filter.minPrice > 0) {
      queryBuilder.whereGreaterThanOrEqualsTo(keyAdPrice, filter.minPrice);
    }

    if (filter.maxPrice != null && filter.maxPrice > 0) {
      queryBuilder.whereLessThanOrEqualTo(keyAdPrice, filter.maxPrice);
    }

    if (filter.vendorType != null &&
        filter.vendorType > 0 &&
        filter.vendorType <
            (VENDOR_TYPE_PARTICULAR | VENDOR_TYPE_PROFESSIONAL)) {
      //verify if there is one or two kinds of vendors selected
      //make a subquery in profiles and verify the type of user (entering in the pointer created in category)

      final userQuery = QueryBuilder<ParseUser>(ParseUser.forQuery());
      if (filter.vendorType == VENDOR_TYPE_PARTICULAR) {
        userQuery.whereEqualTo(keyUserType, UserType.PARTICULAR.index);
      }

      if (filter.vendorType == VENDOR_TYPE_PROFESSIONAL) {
        userQuery.whereEqualTo(keyUserType, UserType.PROFESSIONAL.index);
      }

      queryBuilder.whereMatchesQuery(keyAdOwner,
          userQuery); // its like where keyownerId = userQueryId (subselect)

    }

    //the response is the list with all those filters
    final response = await queryBuilder.query();
    if (response.success && response.results != null) {
      //case is a success, return a list of add
      return response.results
          .map((parseObj) => Ad.fromParse(
              parseObj)) // get the map json and transforming in a list of ads
          .toList();
    } else if (response.success && response.results == null) {
      return []; // case non match from the filters, returning an empty list
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }
}
