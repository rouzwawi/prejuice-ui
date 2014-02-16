'use strict'

angular.module('prejuiceUiApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/result/:userId',
        templateUrl: 'views/result.html'
        controller: 'ResultCtrl'
      .otherwise
        redirectTo: '/'
