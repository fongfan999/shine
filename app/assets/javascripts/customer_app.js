var app = angular.module("customers", ["ngRoute", "templates"])

app.config(["$routeProvider", function($routeProvider) {
  $routeProvider.when("/", {
    controller: "CustomerSearchController",
    templateUrl: "customer_search.html"
  }).when("/:id", {
    controller: "CustomerDetailController",
    templateUrl: "customer_detail.html"
  });
}]);

var CustomerSearchController = function($scope, $http, $location) {
  var page = 0;
  $scope.search = function(searchTerm) {
    if (searchTerm.length < 3) {
      return;
    }
    
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

  $scope.viewDetails = function(customer) {
    $location.path("/" + customer.id);
  };
};

var CustomerDetailController = function($scope, $http, $routeParams) {
  var customerId = $routeParams.id;
  $scope.customer = {};

  $http.get(
    "/customers/" + customerId + ".json"
  ).then(function(response) {
    $scope.customer = response.data;
  }, function(response) {
    alert("There was a problem: " + response.status);
  });
};

app.controller("CustomerSearchController",
  ["$scope", "$http", "$location", CustomerSearchController]);

app.controller("CustomerDetailController",
  ["$scope", "$http", "$routeParams", CustomerDetailController]);