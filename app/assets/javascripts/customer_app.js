var app = angular.module("customers", [])

var CustomerSearchControl = function($scope, $http) {
  $scope.customers = []
  $scope.search = function(searchTerm) {
    $http.get("/customers.json",
      { "params": { "keywords": searchTerm } }
    ).then(function(response) {
      $scope.customers = response.data
    }, function(response) {
      alert("There was a problem: " + response.status)
    });
  }
}

app.controller("CustomerSearchControl",
  ["$scope", "$http", CustomerSearchControl]);