'use strict'

angular.module('prejuiceUiApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'angles'
])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/result/:userToken',
        templateUrl: 'views/result.html'
        controller: 'ResultCtrl'
      .when '/test',
        templateUrl: 'views/test.html'
        controller: 'TestCtrl'
      .otherwise
        redirectTo: '/'
