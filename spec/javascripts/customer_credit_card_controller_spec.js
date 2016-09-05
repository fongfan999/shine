describe("CustomerCreditCardController", function() {
  describe("Initialization", function() {
    var scope = null,
        cardholderId = 42,
        controller = null,
        httpBackend = null,
        cardInfo = {
          lastFour: '4321',
          cardType: "Visa",
          expirationMonth: 3,
          expirationYear: 2018,
          detailsLink: "http://billing.example.com/foo"
        };

    beforeEach(module("customers"));

    beforeEach(inject(function($controller, $rootScope, $httpBackend) {
      scope = $rootScope.$new();
      httpBackend = $httpBackend;

      httpBackend.when('GET',
        '/fake_billing.json?cardholder_id=' + cardholderId
      ).respond(cardInfo);

      controller = $controller("CustomerCreditCardController", {
        $scope: scope
      });
    }));

    it("does not hit the backend initially", function() {
      expect(scope.creditCard).not.toBeDefined();
    });

    it("when setCardholderId is called, hits back-end", function() {
      scope.setCardholderId(cardholderId);
      expect(scope.creditCard).toBeDefined();
      expect(scope.creditCard.lastFour).not.toBeDefined();
      httpBackend.flush();
      expect(scope.creditCard).toEqualData(cardInfo);
    });
  });
});