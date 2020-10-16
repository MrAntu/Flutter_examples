import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';
import '../pages/index_page.dart';

Handler rootHandler = Handler(
    handlerFunc: (context, params) {
      return IndexPage();
    }
);


Handler detailsHandler = Handler(
    handlerFunc: (context, params) {
      String goodsId = params['id'].first;
      return DetailsPage(goodsId);
    }
);


