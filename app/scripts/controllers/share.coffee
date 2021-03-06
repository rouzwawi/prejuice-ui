angular.module('prejuiceUiApp')
  .controller 'shareCtrl', ['$scope', '$routeParams', 'API', 'Facebook', ($scope, $routeParams, API, Facebook) ->

    userToken = $routeParams.userToken

    # Here, usually you should watch for when Facebook is ready and loaded
    $scope.$watch ()->
      $scope.shareLinkClean = 'http://fordomstestet.se/x/' + userToken
      $scope.shareLink = encodeURI($scope.shareLinkClean)
      $scope.shareText = 'Jag är lika fördomsfull som ' + leaders[$scope.selectedLeaderRow-1].name
      $scope.tweetLink = 'https://twitter.com/share?text=' + encodeURIComponent($scope.shareText) + '&hashtags=f%C3%B6rdomstestet.se&url=' + $scope.shareLink
      Facebook.isReady() # This is for convenience, to notify if Facebook is loaded and ready to go.
    , (newVal)->
      #console.log 'facebook ready', newVal
      $scope.facebookReady = true # You might want to use this to disable/show/hide buttons and else

    # From now and on you can use the Facebook service just as Facebook api says
    # Take into account that you will need $scope.$apply when being inside Facebook functions scope and not angular
    $scope.login = ()->
      Facebook.login (response)->
        if response.authResponse
          # The person logged into your app
          $scope.$apply ()->
            $scope.me()
        else
          # The person cancelled the login dialog

    $scope.facebookShare = ()->
      #console.log 'i should login'
      Facebook.login (response)->
        #console.log response

    $scope.getLoginStatus = ()->
      #console.log 'get status', Facebook.isReady()
      Facebook.getLoginStatus (response)->
        #console.log 'status', response
        if response.status is 'connected'
          $scope.$apply ()->
            $scope.loggedIn = true
            $scope.me()
        else
          $scope.$apply ()->
            $scope.loggedIn = false
            $scope.login()

    $scope.me = ()->
      #console.log 'call me'
      Facebook.api '/me', (response)->
        $scope.$apply ()->
          # Here you could re-check for user status (just in case)
          $scope.user = response
          $scope.fbShare()

    $scope.fbShare = ()->
      if window.mobilecheck()
        # alert 'on mobile'
        window.location = 'https://www.facebook.com/sharer/sharer.php?u=' + $scope.shareLink
      else
        # alert 'sharing'
        Facebook.ui
          method: 'share'
          href: $scope.shareLinkClean
        , (response)->
          #console.log 'shared', response
  ]
