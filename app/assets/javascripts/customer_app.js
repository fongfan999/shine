var app = angular.module("customers", [])

var CustomerSearchControl = function($scope) {
  $scope.search = function(searchTerm) {
    $scope.searchedFor = searchTerm;
  }
}

app.controller("CustomerSearchControl",
                ["$scope", CustomerSearchControl]);