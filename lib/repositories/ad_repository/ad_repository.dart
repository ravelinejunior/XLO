import 'dart:io';

import 'package:olx_project_parse/models/ad.dart';
import 'package:olx_project_parse/repositories/response_errors/parse_errors.dart';
import 'package:olx_project_parse/repositories/tables_keys/table_key.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart' as path;

//objetos do parse so comunicam com objetos dos parse
class AdRepository {
  Future<Ad> save(Ad ad) async {
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
      adObject.set<String>(keyAdDistrict, ad.address.disctrict);
      adObject.set<String>(keyAdFederativeUnit, ad.address.uf.initials);
      adObject.set<String>(keyAdPostalCode, ad.address.cep);

      adObject.set<List<ParseFile>>(keyAdImages, parseImages);
      adObject.set<ParseObject>(keyAdOwner, parseUser);
      adObject.set<ParseObject>(keyAdCategory,
          ParseObject(keyCategoryTable)..set(keyCategoryId, ad.category.id));
      final response = await adObject.save();

      if (response.success) {
        return Ad.fromParse(response.result);
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
}
