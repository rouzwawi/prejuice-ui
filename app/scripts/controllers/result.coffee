'use strict'

angular.module('prejuiceUiApp')
  .controller 'ResultCtrl', ['$scope', '$routeParams', 'API', 'Alert', ($scope, $routeParams, API, Alert) ->
    
    $scope.leaderTypePosition = 2
    $scope.selectedLeaderRow = 2
    
    userToken = $routeParams.userToken
    
    API.answers.get = (id, callback)->
      console.log 'running dummy function'
      dummy = {"total":0.4690852244404218,"1":{"0":{"myAnswer":10.0,"myScore":0.07024793388429752,"correct":3.2,"average":8.2968,"overall":0.06814876033057851},"1":{"myAnswer":10.0,"myScore":0.0445859872611465,"correct":5.8,"average":10.8112,"overall":0.05832227835127023},"2":{"myAnswer":50.0,"myScore":0.1690901537183216,"correct":9.3,"average":25.312799999999996,"overall":0.12942494784477174}},"0":{"0":{"myAnswer":1.0,"myScore":1.0,"correct":2.5,"average":2.6239999999999997,"overall":0.3109333333333334},"1":{"myAnswer":7.9,"myScore":0.4615384615384617,"correct":6.1,"average":4.677600000000001,"overall":0.31148114630467566},"2":{"myAnswer":30.4,"myScore":0.6545454545454545,"correct":88.0,"average":78.10000000000002,"overall":0.1984848484848486}},"2":{"0":{"myAnswer":100.0,"myScore":0.25925925925925924,"correct":93.0,"average":91.93600000000002,"overall":0.2401417069243157},"1":{"myAnswer":100.0,"myScore":0.047619047619047616,"correct":99.0,"average":94.904,"overall":0.17703776683087036},"2":{"myAnswer":100.0,"myScore":0.3333333333333333,"correct":90.0,"average":89.57599999999998,"overall":0.2518666666666666}},"3":{"0":{"myAnswer":0.0,"myScore":0.375,"correct":60.0,"average":48.656000000000006,"overall":0.13823333333333332},"1":{"myAnswer":10.0,"myScore":0.7058823529411765,"correct":34.0,"average":28.82,"overall":0.2796256684491979},"2":{"myAnswer":1.0,"myScore":0.9,"correct":10.0,"average":11.075999999999999,"overall":0.22395555555555557}}}
      console.log dummy
      setTimeout(()->
        $scope.$apply ()->
          callback dummy
      , 500)
    
    answers = API.answers.get
      id: userToken
    , (res)->
      answers = res #remove this after dummy test
      
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
      $scope.chart.data.comp[0].data = all
      
    , (err)->
      Alert.add 'error', 'Could not get answers (' + err.status + ')'
      
    
    $scope.chart =
      data:
        xScale: "ordinal"
        yScale: "linear"
        yMin: 0
        yMax: 100
        type: "line-dotted"
        main: [
          className: ".pizza"
          data: []
        ]
        comp: [
          className: ".pizza"
          type: "line"
          data: []
        ]
      options:
        axisPaddingTop: 20
        tickHintX: 100
        axisPaddingLeft: 0
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
