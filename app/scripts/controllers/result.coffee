'use strict'

angular.module('prejuiceUiApp')
  .controller 'ResultCtrl', ['$scope', '$routeParams', 'API', 'Alert', ($scope, $routeParams, API, Alert) ->
    
    $scope.score = 16
    
    userToken = $routeParams.userToken
    
    answers = API.answers.get
      id: userToken
    , (res)->
      $scope.answers = answers.answers
      console.log $scope.answers
    , (err)->
      Alert.add 'error', 'Could not get answers (' + err.status + ')'
      
    $scope.chart = [
      {
        value: 30
        color: "#F7464A"
      }
      {
        value: 50
        color: "#E2EAE9"
      }
      {
        value: 100
        color: "#D4CCC5"
      }
      {
        value: 40
        color: "#949FB1"
      }
      {
        value: 120
        color: "#4D5360"
      }
    ]
    
    $scope.increase = ()->
      $scope.chart[0].value++
      
    $scope.decrease = ()->
      $scope.chart[0].value++
    
    $scope.options =
  
      #Boolean - Whether we should show a stroke on each segment
      segmentShowStroke: true
  
      #String - The colour of each segment stroke
      segmentStrokeColor: "#fff"
  
      #Number - The width of each segment stroke
      segmentStrokeWidth: 2
  
      #The percentage of the chart that we cut out of the middle.
      percentageInnerCutout: 50
  
      #Boolean - Whether we should animate the chart
      animation: true
  
      #Number - Amount of animation steps
      animationSteps: 100
  
      #String - Animation easing effect
      animationEasing: "easeOutBounce"
  
      #Boolean - Whether we animate the rotation of the Doughnut
      animateRotate: true
  
      #Boolean - Whether we animate scaling the Doughnut from the centre
      animateScale: false
  
      #Function - Will fire on animation completion.
      onAnimationComplete: null
    
  ]
