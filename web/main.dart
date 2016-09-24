// Copyright (c) 2016, ofadeyi. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2/platform/browser.dart';
import 'package:http/browser_client.dart';

import 'package:dart_angular2_pirate_badge/app_component.dart';

main() {
  bootstrap(
      AppComponent, [
      provide(BrowserClient, useFactory: () => new BrowserClient(), deps: [])
    ]);
}
