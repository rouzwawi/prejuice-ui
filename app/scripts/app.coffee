'use strict'

app = angular.module('prejuiceUiApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'ngAnimate',
  'facebook'
]).config [
  '$routeProvider',
  '$locationProvider',
  'FacebookProvider',
  ($routeProvider, $locationProvider, FacebookProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/:userToken',
        templateUrl: 'views/result.html'
        controller: 'ResultCtrl'
      .otherwise
        redirectTo: '/'

    # Here you could set your appId throug the setAppId method and then initialize
    # or use the shortcut in the initialize method directly.
    FacebookProvider.init '469787509789276'
  ]