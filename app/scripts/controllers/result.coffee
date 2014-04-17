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
      $scope.totalPercentage = Number(answers.total*100).toFixed(0)
      
      $scope.leaderTypePosition = 11-Math.ceil(answers.total*10)
      $scope.selectedLeaderRow = $scope.leaderTypePosition
      
      mine = []
      all = []
      for q in [0...4]
        for i in [0...3]
          index = (q*3)+i+1
          mine.push
            x: index
            y: Math.round(answers[q][i].myScore * 100)
          all.push
            x: index
            y: Math.round(answers[q][i].overall * 100)
            
      $scope.chart.data.main[0].data = mine
      $scope.chart.data.comp[0].data = mine

    , (err)->
      Alert.add 'error', 'Could not get answers (' + err.status + ')'
      
    
    $scope.chart =
      data:
        xScale: "ordinal"
        yScale: "linear"
        yMin: 0
        yMax: 100
        type: "line"
        main: [
          className: ".pizza"
          data: []
        ]
        comp: [
          className: ".pizza"
          type: "line-dotted"
          data: []
        ]
      options:
        mouseover: (data, i)->
          $scope.$apply ()->
            $scope.hoverQuestion = "bla " + i
          console.log data
          console.log i
    
    
    
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
      return (100 - (leaderPosition * 10)) + '-' + (100 - ((leaderPosition-1) * 10)) + '%'
    
  ]
