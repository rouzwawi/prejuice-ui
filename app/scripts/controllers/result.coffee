'use strict'

angular.module('prejuiceUiApp')
  .controller 'ResultCtrl', ['$scope', '$routeParams', 'API', 'Alert', ($scope, $routeParams, API, Alert) ->
    
    #Set page title
    document.title = "Fördomstestet: Din fördomsprofil"

    $scope.leaderTypePosition = 2
    $scope.selectedLeaderRow = 2

    userToken = $routeParams.userToken

    questions = API.questions.get (res)->
      $scope.questions = res.questions
    
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
          
      $scope.chart.data.main[0].data = all
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
          className: ".all"
          data: []
        ]
        comp: [
          className: ".mine"
          type: "line-dotted"
          data: []
        ]
      options:
        axisPaddingTop: 0
        axisPaddingRight: 0
        axisPaddingLeft: 0
        axisPaddingBottom: 0
        paddingTop: 50
        paddingLeft: 40
        paddingRight: 0
        paddingBottom: 15
        #showAllXTicks: true
        mouseover: (data, i)->
          questionParentIndex = Math.floor(i / 3)
          subQuestionIndex = Math.floor(i % 3)
          subQuestion = $scope.questions[questionParentIndex].subQuestions[subQuestionIndex]
          subAnswer = ($scope.answers[questionParentIndex])[subQuestionIndex]
          $scope.$apply ()->
            $scope.hoverRangeUnit = subQuestion.rangeUnit
            $scope.hoverQuestion = subQuestion.question
            $scope.hoverMyAnswer = subAnswer.myAnswer
            $scope.hoverMyScore = Math.round(subAnswer.myScore*100)
            $scope.hoverCorrect = subAnswer.correct
            $scope.hoverAverage = (Math.round(subAnswer.average*10) / 10)
            $scope.hoverOverall = Math.round(subAnswer.overall*100)
          $('g.mine circle').eq(i).css('fill','#74b4b4')
        mouseout: (data, i)->
          $('g.mine circle').eq(i).css('fill','#606060')
        tickFormatY: (y)->
          return y + '%'
    
    
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

    #Google Analytics
    ((i, s, o, g, r, a, m) ->
      i["GoogleAnalyticsObject"] = r
      i[r] = i[r] or ->
        (i[r].q = i[r].q or []).push arguments
        return


      i[r].l = 1 * new Date()

      a = s.createElement(o)
      m = s.getElementsByTagName(o)[0]

      a.async = 1
      a.src = g
      m.parentNode.insertBefore a, m
      return
    ) window, document, "script", "//www.google-analytics.com/analytics.js", "ga"
    ga "create", "UA-50452169-1", "fordomstestet.se"
    ga "send", "pageview"

    #console.log 'Google Analytics triggered, passed: ' + document.title
    
  ]
