var app = angular.module("customers", [])

var CustomerSearchControl = function($scope, $http) {
  var page = 0;
  $scope.search = function(searchTerm) {
    $http.get("/customers.json",
      { "params": { "keywords": searchTerm, "page": page } }
    ).then(function(response) {
      $scope.customers = response.data;
      if (page == 0) {
        angular.element(".previous").addClass("disabled");
      };
    }, function(response) {
      alert("There was a problem: " + response.status);
    });
  };

  $scope.previousPage = function() {
    if (page > 0) {
      page = page - 1;
      $scope.search($scope.keywords);
    };
  };

  $scope.nextPage = function() {
    angular.element(".previous").removeClass("disabled");
    page = page + 1;
    $scope.search($scope.keywords);
  };
}

app.controller("CustomerSearchControl",
  ["$scope", "$http", CustomerSearchControl]);