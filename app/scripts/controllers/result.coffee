'use strict'

angular.module('prejuiceUiApp')
  .controller 'ResultCtrl', ['$scope', '$routeParams', 'API', 'Alert', ($scope, $routeParams, API, Alert) ->
    
    $scope.leaderTypePosition = 2
    $scope.selectedLeaderRow = 2
    
    userToken = $routeParams.userToken
    
    answers = API.answers.get
      id: userToken
    , (res)->
      $scope.answers = answers
      mine = []
      all = []
      for q in [0...4]
        for i in [0...3]
          mine.push Math.round(answers[q][i].myScore * 100)
          all.push Math.round(answers[q][i].overall * 100)
      $scope.chart.datasets[0].data = mine
      $scope.chart.datasets[1].data = all

    , (err)->
      Alert.add 'error', 'Could not get answers (' + err.status + ')'
      
    $scope.chart = 
      labels: [
        "1"
        "2"
        "3"
        "4"
        "5"
        "6"
        "7"
        "8"
        "9"
        "10"
        "11"
        "12"
      ]
      datasets: [
        {
          fillColor: "rgba(220,220,220,0.0)"
          strokeColor: "rgba(86,149,149,1)"
          pointColor: "rgba(86,149,149,1)"
          pointStrokeColor: "#fff"
          data: []
        }
        {
          fillColor: "rgba(151,187,205,0.5)"
          strokeColor: "rgba(151,187,205,1)"
          pointColor: "rgba(151,187,205,1)"
          pointStrokeColor: "#fff"
          data: []
        }
      ]
    
    $scope.selectLeaderRow = (pos)->
      $scope.selectedLeaderRow = pos
    
    $scope.getRowClass = (pos)->
      if $scope.selectedLeaderRow == pos and $scope.leaderTypePosition == pos
        return 'selected-and-active'
      else if $scope.selectedLeaderRow == pos
        return 'selected'
      else if $scope.leaderTypePosition == pos
        return 'active'
      return ''
    
    $scope.getLeader = (leaderPosition)->
      return leaders[leaderPosition-1]
      
    $scope.getLeaderPercentage = (leaderPosition)->
      return (100 - (leaderPosition-1) * 10) + '-' + (100 - (leaderPosition * 10)) + '%'
    
  ]
