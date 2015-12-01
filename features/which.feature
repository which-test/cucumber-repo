Feature: Logged out users view of the TV review page

  In order to get the best available TVs on the market
  As a consumer
  I want to be able to find all available TVs on the market according to specific criteria(s)

  Scenario: As a logged out user I get a promotion banner to sign up for the site
    Given I have navigated to the TV review page
    Then a promotion banner is displayed for me to sign up

  Scenario Outline: As a logged out user I should be able to sort the list of TV products
    Given I have navigated to the TV review page
    When I sort the product list according to <order>
    Then it is sorted correctly according to <order>

  Examples:
    | order                     |
    | Most-recently tested      |
    | Price (low to high)       |
    | Price (high to low)       |
    | Screen size (high to low) |
    | Most-recently launched    |

  Scenario Outline: As a logged out user I should not be able to select Which's highest score
  Given I have navigated to the TV review page
  When I sort the product list according to <order>
  Then I am not allowed to do so as a logged out user

  Examples:
  |order|
  | Highest Which? score |

  Scenario: As a logged out user I can filter on price range
    Given I have navigated to the TV review page
    When I try to filter on price range
    Then I get TV products displayed for that price range

  Scenario: As a user I should be able to clear all filters set
  Given I have navigated to the TV review page
  When I try to filter on price range
  And I clear the results
  Then my original view is displayed again