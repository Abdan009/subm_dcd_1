import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding/common/enums.dart';
import 'package:restaurant_dicoding/common/methods.dart';
import 'package:restaurant_dicoding/data/api/api_service.dart';
import 'package:restaurant_dicoding/data/models/menu_item_model.dart';
import 'package:restaurant_dicoding/data/models/models.dart';
import 'package:restaurant_dicoding/data/models/review_model.dart';
import 'package:restaurant_dicoding/data/providers/detail_restaurant_provider.dart';
import 'package:restaurant_dicoding/data/providers/restaurant_provider.dart';
import 'package:restaurant_dicoding/data/providers/search_restaurant_provider.dart';

import '../../common/styles.dart';
import '../widgets/widgets.dart';

part 'restaurants_ui.dart';
part 'detail_restaurant_ui.dart';
part 'param_not_found_ui.dart';
part 'search_restaurant_ui.dart';
part 'no_connectivity_ui.dart';